//
//  SecurePasswordView.swift
//  SecureKit
//
//  Created by Tolga Taner on 14.02.2022.
//

import UIKit.UIView

public final class SecurePasswordView: UIView {

    @IBOutlet public weak var element: UITextField!
    
    public var manager: PasswordManager!
    public var password: String = String()
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        fromNib()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
    }
    
    public func setup(iv: String, key: String) throws {
        do {
            manager = try PasswordManager(storedValue: element.text ?? "",
                                      iv: iv,
                                      key: key)
        }
        catch(let error) {
            fatalError(error.localizedDescription)
        }
        element.delegate = self
    }
    
    fileprivate func encrypt(_ text: String) {
        manager.set(text)
        do {
            password = try manager.encrypt()
        }
        catch(let error) {
            fatalError(error.localizedDescription)
        }
    }
    
}

//MARK: - UITextFieldDelegate
extension SecurePasswordTextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        encrypt(textField.text ?? "")
        return true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        password.removeAll()
        manager.deleteFromKeychain()
        manager.password.removeAll()
        return true
    }
}
