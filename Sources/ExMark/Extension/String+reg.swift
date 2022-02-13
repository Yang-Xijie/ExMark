// String+reg.swift

import Foundation
import XCLog

extension String {
    /// return `nil` if not match
    ///
    /// Usage:
    ///
    /// ```swift
    /// let str = "code swift"
    /// let result = str.getSubstringBy(reg: "(?<=code )[a-zA-Z0-9]+") // Optional("swift")
    /// ```
    func getSubstringBy(reg: String) -> String? {
        do {
            let regex = try NSRegularExpression(pattern: reg, options: [])
            if let checkingResult = regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.utf16.count)) {
                let result = (self as NSString).substring(with: checkingResult.range)
                return result
            } else {
                // not matched
                return nil
            }
        } catch let error as NSError {
            // error
            XCLog(.error, error.localizedDescription)
            return nil
        }
    }
}
