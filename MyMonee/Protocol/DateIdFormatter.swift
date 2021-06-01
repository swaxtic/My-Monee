//
//  DateFormatter.swift
//  MyMonee
//
//  Created by MacBook on 19/05/21.
//

import Foundation
protocol DateIdFormatter {
    func dateFormatter() -> String
}

extension String {
    var dateFormatter: String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ID")
        formatter.dateFormat = "dd MMM yyyy - HH:mm"
        return formatter.string(from: date)
    }
}
