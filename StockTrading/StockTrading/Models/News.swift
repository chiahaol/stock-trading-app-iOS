//
//  News.swift
//  StockTrading
//
//  Created by Jason Liu on 5/1/22.
//

import Foundation

struct News: Codable {
    let category: String
    let datetime: Int
    let headline: String
    let id: Int
    var image: String
    let related: String
    let source: String
    let summary: String
    let url: String
}
