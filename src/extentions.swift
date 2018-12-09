

import Foundation
import UIKit

extension Date {
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
}

extension String {
    var floatValue: CGFloat {
        return CGFloat((self as NSString).floatValue)
    }
}
