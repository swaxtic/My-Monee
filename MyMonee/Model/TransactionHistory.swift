//
//  TransactionHistory.swift
//  MyMonee
//
//  Created by MacBook on 14/05/21.
//

import Foundation

struct TransactionHistory {
    var title: String
    var amount: Double
    var dateTime: String
    var transactionType: TransactionType
    var id: String
    
    init(title: String, amount: Double, dateTime: String, transactionType: TransactionType, id: String) {
        self.title = title
        self.amount = amount
        self.dateTime = dateTime
        self.transactionType = transactionType
        self.id = id
    }
}
var dataTransactionHistory: [TransactionHistory] = [
]
