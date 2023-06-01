//
//  FavoriteObj.swift
//  StockTrading
//
//  Created by Jason Liu on 5/2/22.
//

import Foundation


struct FavoriteObj: Codable {
    let symbol: String
    let name: String
    var c: Float
    var d: Float
    var dp: Float
}
