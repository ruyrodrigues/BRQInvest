//
//  Currency.swift
//  iOS - BRQ Invest
//
//  Created by Ruy on 10/09/21.
//

import Foundation

struct Results: Codable {
    let currencies: Currencies
}

struct Currencies: Codable {
    let source: String
    let USD, EUR, GBP, ARS, CAD, AUD, JPY, CNY, BTC: Currency
}

struct Currency: Codable {

    let buy: Double
    let name: String
    let sell: Double?
    let variation: Double
    
}

