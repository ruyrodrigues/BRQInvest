//
//  UserData.swift
//  iOS - BRQ Invest
//
//  Created by Ruy Miguel Penha Rodrigues on 15/09/21.
//

import Foundation

class User {
    
    var balance: Double
    let defaultAPICurrencies = ["USD", "EUR", "GBP", "ARS", "AUD", "BTC", "CAD", "CNY", "JPY"]
    
    var userWallet: [String: Int]
    
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
        var wallet = [String: Int]()
        for iso in defaultAPICurrencies {
            wallet[iso] = 0
        }
        self.userWallet = wallet
    }
    
    func buy(quantity: Int, _ currencyIso: String, _ currency: Currency) {
        guard let currencyAmount = userWallet[currencyIso] else { return }
        guard let buyCurrencyPrice = currency.buy else { return }
        
        let price = buyCurrencyPrice * Double(quantity)
        
        if balance - price > 0 {
            userWallet[currencyIso] = currencyAmount + quantity
            balance -= price
        }
        
    }
}
