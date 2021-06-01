//
//  UserData.swift
//  MyMonee
//
//  Created by MacBook on 18/05/21.
//

import Foundation

struct UserData {
    var name: String
    var balance: Double
    var debit: Double
    var credit: Double
    
    init(name: String, balance: Double, debit: Double, credit: Double) {
        self.name = name
        self.balance = balance
        self.debit = debit
        self.credit = credit
    }
}
var dataProfile = UserData(name: "Your Nameee", balance: 0.0, debit: 0.0, credit: 0.0)
