// String+spaceCountAtBeginning.swift

import Foundation

extension String {
    var spaceCountAtBeginning: Int {
        var str = self
        var result = 0

        while true {
            if let c = str.first, c == " " {
                result += 1
                str.remove(at: str.startIndex)
            } else {
                break
            }
        }

        return result
    }
}
