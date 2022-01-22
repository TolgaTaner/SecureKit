//
//  OtpManager.swift
//  SecureKit
//
//  Created by Tolga Taner on 20.01.2022.
//

import Foundation
import CryptoSwift
import CommonCrypto

public protocol OneTimePassword {
    var code: String { get set }
}

public class OtpManager: SecureManager {
    
    //MARK: - OneTimePassword
    public var code: String
    
    enum Error: Swift.Error {
        case cantConvertToData
        case cantConvertToHexadecimal
        case cantConvertToString
        case cantUseRegex
        case lengthNotSupported
        case cantRetrieveFromKeychain
        
        var localizedDescription: String {
            switch self {
            case .cantConvertToData: return "SecureKit: Sensitive data type doesn't convert to data."
            case .cantConvertToHexadecimal: return "SecureKit: Sensitive data type doesn't convert to hexadecimal."
            case .cantConvertToString: return "SecureKit: Sensitive data type doesn't to convert string from data."
            case .cantUseRegex: return "SecureKit: Can't use regex."
            case .lengthNotSupported: return "SecureKit: Length is not supported."
            case .cantRetrieveFromKeychain: return "SecureKit: Can't store expected data."
            }
        }
    }
    
    init(code: String) {
        self.code = code
    }
    
    //MARK: - CryptionSettings
    required convenience public init(code: String, iv: String, key: String) throws {
        guard key.count == kCCKeySizeAES128 || key.count == kCCKeySizeAES256,
              let _ = key.data(using: .utf8) else {
                  debugPrint("SecureKit: Key should be 13 or 26 characters.")
                  throw Error.lengthNotSupported
              }
        guard iv.count == kCCBlockSizeAES128, let _ = iv.data(using: .utf8) else {
            debugPrint("SecureKit: IV should be 13 characters.")
            throw Error.lengthNotSupported
        }
        if code.count != 6 {
            debugPrint("SecureKit: Code should be 6 characters.")
        }
        self.init(code: code)
        self.iv = iv
        self.key = key
    }
    
}

extension OtpManager: CryptionSettings {}
extension OtpManager: OneTimePassword {}

//MARK: - Cryption
extension OtpManager: Cryption {
    public func encrypt() throws -> String {
        guard let data = code.data(using: .utf8) else { throw Error.cantConvertToData }
        do {
            let encrypted = try AES(key: key, iv: iv, padding: .pkcs7).encrypt([UInt8](data))
            let encryptedData = Data(encrypted)
            let encryptedString: String = encryptedData.toHexString()
            createInKeychain(forValue: encryptedString)
            return encryptedString
        }
        catch {
            throw SecureManager.Error.encryptionError
        }
    }
    
    public func decrypt() throws -> String {
        do {
            let encryptedString: String = try retrieveFromKeychain()
            guard let data = try encryptedString.dataFromHexadecimalString() else { throw Error.cantConvertToHexadecimal }
            do {
                let decrypted = try AES(key: key, iv: iv, padding:.pkcs7).decrypt([UInt8](data))
                let decryptedData = Data(decrypted)
                guard let decryptedString: String = String(bytes: decryptedData.bytes, encoding: .utf8)
                else {
                    throw Error.cantConvertToString
                }
                deleteFromKeychain()
                return decryptedString
            }
            catch {
                throw SecureManager.Error.decryptionError
            }
        }
        catch {
            throw Error.cantRetrieveFromKeychain
        }
    }
    
}
