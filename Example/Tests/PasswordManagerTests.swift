//
//  PasswordManagerTests.swift
//  SecureKit_Tests
//
//  Created by Tolga Taner on 19.02.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
import SecureKit

final class PasswordManagerTests: XCTestCase {

    private var sut: PasswordManager!
    
    private enum DummyError: Swift.Error {
        case cantInitialization
    }
    
    override func setUp() {
        super.setUp()
        setup()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testCodeEncryptedSuccessfully() {
        XCTAssertTrue(sut.password == "Tt1Ttl!")
        let result = try! sut.encrypt()
        XCTAssertFalse(result == sut.password)
    }
    
    private func setup() {
        do {
            let key = "2tC2H19lkVbQDfakxcrtNMQdd0FloLyw"
            let iv = "bbC2H19lkVbQDfak"
            sut = try PasswordManager(storedValue: "Tt1Ttl!", iv: iv, key: key)
        }
        catch {
            XCTAssertThrowsError(DummyError.cantInitialization)
        }
    }

}

//MARK: - InitializationTestCase
extension PasswordManagerTests: InitializationTestCase {
    
    func testValuesSettingIsCorrect() {
        XCTAssertTrue(sut.key == "2tC2H19lkVbQDfakxcrtNMQdd0FloLyw")
        XCTAssertTrue(sut.iv == "bbC2H19lkVbQDfak")
        XCTAssertTrue(sut.password == "Tt1Ttl!")
    }
    
}
