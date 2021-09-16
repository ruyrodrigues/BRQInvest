//
//  UserData.swift
//  iOS - BRQ Invest
//
//  Created by Ruy Miguel Penha Rodrigues on 15/09/21.
//

import Foundation

class User {
    var balance: Double
    
    var balanceLabel: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        if let result = formatter.string(from: NSNumber(value: balance)) {
            return result
        }
        return "R$0.00"
    }
    
    
    init() {
        self.balance = 1000
    }
}
