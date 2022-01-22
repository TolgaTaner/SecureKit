

import CryptoSwift

extension String {
    
    enum Error: Swift.Error {
        case cantUseRegex
    }
    
    func dataFromHexadecimalString() throws -> Data? {
        var data = Data(capacity: count / 2)
        do {
            let regex = try NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
            regex.enumerateMatches(in: self, options: [], range: NSMakeRange(0, count)) { match, flags, stop in
                guard let match = match else { return }
                let byteString = (self as NSString).substring(with: match.range)
                guard let num = UInt8(byteString, radix: 16) else { return }
                data.append(num)
            }
        }
        catch {
            throw Error.cantUseRegex
        }
        return data
    }
    
}
