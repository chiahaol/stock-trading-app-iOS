//
//  QuoteViewModel.swift
//  StockTrading
//
//  Created by Jason Liu on 4/30/22.
//

import Foundation

@MainActor
class QuoteViewModel :ObservableObject {
    @Published var quote: QuoteResponse? = nil
    
    func getQuote(symbol: String) async {
        self.quote = await WebServices().getQuote(symbol: symbol)
    }
}
