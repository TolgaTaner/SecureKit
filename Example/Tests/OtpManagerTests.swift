import XCTest
import SecureKit

final class OtpManagerTests: XCTestCase {
    
    private var sut: OtpManager!
    
    private enum DummyError: Swift.Error {
        case cantInitialization
        case encryptionError
        case decryptionError
        case cantStore
    }
    
    override func setUp() {
        super.setUp()
        setup()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testValuesSettingIsCorrect() {
        XCTAssertTrue(sut.key == "2tC2H19lkVbQDfakxcrtNMQdd0FloLyw")
        XCTAssertTrue(sut.iv == "bbC2H19lkVbQDfak")
        XCTAssertTrue(sut.code == "987654")
    }
    
    func testCodeEncryptedSuccessfully() {
        XCTAssertTrue(sut.code == "987654")
        let result = try! sut.encrypt()
        XCTAssertFalse(result == sut.code)
    }
    
    func testCodeDecryptedSuccessfully() {
        XCTAssertTrue(sut.code == "987654")
        let encryptedResult = try! sut.encrypt()
        XCTAssertFalse(encryptedResult == "987654")
        let result = try! sut.decrypt()
        XCTAssertTrue(result == "987654")
    }
    
    private func setup() {
        do {
            let key = "2tC2H19lkVbQDfakxcrtNMQdd0FloLyw"
            let iv = "bbC2H19lkVbQDfak"
            sut = try OtpManager(storedValue: "987654", iv: iv, key: key)
        }
        catch {
            XCTAssertThrowsError(DummyError.cantInitialization)
        }
    }
    
    
}
