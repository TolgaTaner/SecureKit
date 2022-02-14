//
//  PasswordViewController.swift
//  SecureKit_Example
//
//  Created by Tolga Taner on 7.02.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import SecureKit

class PasswordViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: SecurePasswordView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let key = "2tC2H19lkVbQDfakxcrtNMQdd0FloLyw"
        let iv = "bbC2H19lkVbQDfak"
        try! passwordTextField.setup(iv: iv, key: key)
    }


}
