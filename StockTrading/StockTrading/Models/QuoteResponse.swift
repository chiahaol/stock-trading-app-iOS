//
//  QuoteResponse.swift
//  StockTrading
//
//  Created by Jason Liu on 4/30/22.
//

import Foundation


struct QuoteResponse: Codable {
    let c: Float
    let d: Float
    let dp: Float
    let h: Float
    let l: Float
    let o: Float
    let pc: Float
    let t: Int
}
