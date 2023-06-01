//
//  SocialSentimentsResponse.swift
//  StockTrading
//
//  Created by Jason Liu on 5/1/22.
//

import Foundation


struct SocialSentimentsResponse: Codable {
    let reddit: [SocialSentimentsObj]
    let symbol: String
    let twitter: [SocialSentimentsObj]
}
