//
//  SocialSentimentsObj.swift
//  StockTrading
//
//  Created by Jason Liu on 5/1/22.
//

import Foundation

struct SocialSentimentsObj: Codable {
    let atTime: String
    let mention: Int
    let positiveScore: Float
    let negativeScore: Float
    let positiveMention: Int
    let negativeMention: Int
    let score: Float
}
