//
//  Data+Extension.swift
//  SecureKit
//
//  Created by Tolga Taner on 20.01.2022.
//

import Foundation

extension Data {
    
    var bytes: Array<UInt8> { Array(self) }
    
    func toHexString() -> String { bytes.toHexString() }
    
}
