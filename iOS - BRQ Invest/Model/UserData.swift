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
    
    let defaultAPICurrencies = ["USD", "EUR", "GBP", "ARS", "AUD", "BTC", "CAD", "CNY", "JPY"]
    
    var userWallet: [String: Int]
    
    init() {
        self.balance = 1000
        var wallet = [String: Int]()
        for iso in defaultAPICurrencies {
            wallet[iso] = 0
        }
        self.userWallet = wallet
    }
    
    func sell(quantity: Int, _ currencyIso: String, _ currency: Currency) {
        guard let currencyAmount = userWallet[currencyIso] else { return }
        guard let sellCurrencyPrice = currency.sell else { return }
        
        let sellPrice = sellCurrencyPrice * Double(quantity)
        
        if currencyAmount >= quantity {
            balance += sellPrice
            userWallet[currencyIso] = currencyAmount - quantity
        }
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
