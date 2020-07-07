//
//  Helpers.swift
//  splitwise
//
//  Created by Miles Grant on 7/7/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//

import Foundation

// https://github.com/janwasgint/Cupwise/blob/master/Cupwise/Cupwise/view/other/HelperExtensions.swift
extension Double {
    func roundedWithTwoDecimalPlaces() -> Double {
        return Double((self * 100).rounded()/100)
    }
    func asMoney() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        guard let formattedTipAmount = formatter.string(from: abs(self) as NSNumber) else {
            return ""
        }
        return formattedTipAmount
    }
}
