//
//  SecurePasswordView.swift
//  SecureKit
//
//  Created by Tolga Taner on 14.02.2022.
//

import UIKit.UIView

public final class SecurePasswordView: UIView {
    
    @IBOutlet public weak var textfield: UITextField!
    
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
            manager = try PasswordManager(storedValue: textfield.text ?? "",
                                          iv: iv,
                                          key: key)
        }
        catch(let error) {
            fatalError(error.localizedDescription)
        }
        textfield.delegate = self
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
extension SecurePasswordView: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            if updatedText.isEmpty {
                password.removeAll()
                manager.deleteFromKeychain()
                manager.password.removeAll()
                return true
            }
            encrypt(updatedText)
            return true
        }
        return true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        password.removeAll()
        manager.deleteFromKeychain()
        manager.password.removeAll()
        return true
    }
}
