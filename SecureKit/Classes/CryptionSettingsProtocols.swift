//
//  CryptionSettings+Protocols.swift
//  SecureKit
//
//  Created by Tolga Taner on 21.01.2022.
//

import Foundation

public protocol Cryption {
    func decrypt() throws -> String
    func encrypt() throws -> String
}

public protocol CryptionParameter {
    var iv: String { get }
    var key: String { get }
}

public protocol CryptionSettings {
    init(code: String, iv: String, key: String) throws
}
