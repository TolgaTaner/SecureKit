//
//  KeychainProtocols.swift
//  SecureKit
//
//  Created by Tolga Taner on 22.01.2022.
//

import KeychainSwift

protocol KeychainSettings {
    var storedValueKey: String { get }
    var keychain: KeychainSwift { get }
    
    func createInKeychain(forValue value: String)
    func retrieveFromKeychain() throws -> String
    @discardableResult func deleteFromKeychain() -> Bool
}
