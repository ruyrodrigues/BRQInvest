//
//  Currency.swift
//  iOS - BRQ Invest
//
//  Created by Ruy on 10/09/21.
//

import Foundation

struct FinanceData: Codable {
    let results: Results
}

struct Results: Codable {
    let currencies: Currencies
}

struct Currencies: Codable {
    let source: String
    let USD, EUR, GBP, ARS, AUD, BTC, CAD, CNY, JPY: Currency
}

struct Currency: Codable {

    let name: String
    let buy: Double?
    let sell: Double?
    let variation: Double
    
    var variationString: String {
        return String(format: "%.2f", variation) + "%"
    }
    
    var buyString: String {
        if let buy = buy {
            let NSNumberBuy = NSNumber(value: buy)
            let formatter = setFormatter()
            if let result = formatter.string(from: NSNumberBuy) {
                return result
            }
        }
        return "R$0.00"
    }
    
    var sellString: String {
        if let sell = sell {
            let NSNumberSell = NSNumber(value: sell)
            let formatter = setFormatter()
            if let result = formatter.string(from: NSNumberSell) {
                return result
            }
        }
        return "R$0.00"
    }
    
    func setFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        return formatter
    }
    
}

