//
//  Currency.swift
//  iOS - BRQ Invest
//
//  Created by user on 10/09/21.
//

import Foundation

struct Currency: Codable {
    var name: String
    var buyPrice: Double
    var sellPrice: Double
    var variation: Double
}
