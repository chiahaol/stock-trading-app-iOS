//
//  Portfolio.swift
//  StockTrading
//
//  Created by Jason Liu on 5/1/22.
//

import Foundation

struct Portfolio: Codable {
    let symbol: String
    let name: String
    var amount: Int
    var totalCost: Float
    var currentPrice: Float
}
