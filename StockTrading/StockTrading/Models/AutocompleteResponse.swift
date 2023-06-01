//
//  AutocompleteResponse.swift
//  StockTrading
//
//  Created by Jason Liu on 4/29/22.
//

import Foundation


struct AutocompleteResponse: Codable {
    let count: Int
    let result: [AutocompleteItem]
}


struct AutocompleteItem: Codable {
    let description: String
    let displaySymbol :String
    let symbol: String
    let type: String
}
