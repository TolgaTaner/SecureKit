
import Foundation
import CommonCrypto
import KeychainSwift

public class SecureManager {
    //MARK: - CryptionParameter
    public var iv: String
    public var key: String
    
    enum Error: Swift.Error {
        case encryptionError
        case decryptionError
        case cantStore
        
        var localizedDescription: String {
            switch self {
            case .cantStore: return "SecureKit: Can't store expected value."
            case .encryptionError: return "SecureKit: Can't encrypt expected data."
            case .decryptionError: return "SecureKit: Can't decrypt expected data."
            }
        }
    }
    
    init() {
        self.iv = String()
        self.key = String()
    }
}

extension SecureManager: CryptionParameter {}

//MARK: - KeychainSettings
extension SecureManager: KeychainSettings {
    
    var storedValueKey: String { "otp" }
    var keychain: KeychainSwift { KeychainSwift() }
    
    func retrieveFromKeychain() throws -> String {
        guard let value: String = keychain.get(storedValueKey) else {
            throw Error.cantStore
        }
        return value
    }
    
    func createInKeychain(forValue value: String) {
        keychain.set(value, forKey: storedValueKey, withAccess: .accessibleWhenUnlockedThisDeviceOnly)
    }
    
    @discardableResult func deleteFromKeychain() -> Bool {
        keychain.delete(storedValueKey)
    }
    
}
