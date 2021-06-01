//
//  Impian.swift
//  MyMonee
//
//  Created by MacBook on 15/05/21.
//

import Foundation

struct Impian {
    var title: String
    var currentMoney: Double
    var targetMoney: Double
    //var progressValue: Float
    
    init(title: String, currentMoney: Double, targetMoney: Double) {
        self.title = title
        self.currentMoney = dataProfile.balance
        self.targetMoney = targetMoney
        //self.progressValue = progressValue
    }
}
var dataImpian: [Impian] = [
    Impian(title: "Membeli Iphone", currentMoney: dataProfile.balance, targetMoney: 11000000.0),
    Impian(title: "Membeli Mobil", currentMoney: dataProfile.balance, targetMoney: 280000000.0),
]
