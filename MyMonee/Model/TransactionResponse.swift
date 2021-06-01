//
//  TransactionResponse.swift
//  MyMonee
//
//  Created by MacBook on 20/05/21.
//

import Foundation

struct TransactionResponse: Codable {
    var id: String
    var title: String
    var amount: Double
    var type: String
    var date: String
}

var dataTransactions: [TransactionResponse] = []
var dataTransaction: TransactionResponse = TransactionResponse(id: "", title: "", amount: 0.0, type: "", date: "")
