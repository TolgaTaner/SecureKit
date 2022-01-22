//
//  ViewController.swift
//  SecureKit
//
//  Created by TolgaTaner on 01/20/2022.
//  Copyright (c) 2022 TolgaTaner. All rights reserved.
//

import UIKit
import SecureKit

class ViewController: UIViewController {
    
    var manager: OtpManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        let key = "2tC2H19lkVbQDfakxcrtNMQdd0FloLyw"
        let iv = "bbC2H19lkVbQDfak"
        manager = try! OtpManager(code: "987654", iv: iv, key: key)
        do {
            let encryption = try manager.encrypt()
            print(encryption)
        }
        catch(let error) {
            print(error)
        }
         let decryptionText = try! manager.decrypt()
         print(decryptionText)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

