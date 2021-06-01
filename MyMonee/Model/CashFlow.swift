//
//  CashFlow.swift
//  MyMonee
//
//  Created by MacBook on 14/05/21.
//

import Foundation
struct CashFlow {
    var title: String
    var amount: Double
    var imageName: String
    var transactionType: TransactionType
    
    init(title: String, amount: Double, imageName: String, transactionType: TransactionType) {
        self.title = title
        self.amount = amount
        self.imageName = imageName
        self.transactionType = transactionType
    }
}
var dataCashFlow: [CashFlow] = [
    CashFlow(title: "Uang Masuk", amount: 0.0, imageName: "arrow_upward_24px", transactionType: .credit),
    CashFlow(title: "Uang Keluar", amount: 0.0, imageName: "arrow_downward_24px", transactionType: .debit)
]
