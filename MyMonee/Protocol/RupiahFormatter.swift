//
//  RupiahFormatter.swift
//  MyMonee
//
//  Created by MacBook on 19/05/21.
//

import Foundation
extension Double {
    var rupiahFormatter: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        let formatted = formatter.string(from: self as NSNumber)
        return String("Rp " + formatted!)
    }
}
