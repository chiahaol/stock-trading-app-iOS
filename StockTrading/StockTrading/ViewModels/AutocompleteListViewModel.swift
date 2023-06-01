//
//  AutocompleteListViewModel.swift
//  StockTrading
//
//  Created by Jason Liu on 4/29/22.
//

import Foundation

class AutocompleteListViewModel: ObservableObject {
    @Published var autocompleteList: [AutocompleteItem] = []
    
    var workItem: DispatchWorkItem?
    
    func getAutocompleteList(symbol: String) async {
        self.autocompleteList = []
        self.workItem?.cancel()
        let newWorkItem = DispatchWorkItem {
            Task.init {
                    let autocompleteResponse = await WebServices().getAutocomplete(symbol: symbol)
                    DispatchQueue.main.async {
                        self.autocompleteList = autocompleteResponse?.result ?? []
                        self.autocompleteList = self.autocompleteList.filter { item in
                            return item.type == "Common Stock" && !item.symbol.contains(".")
                    }
                }
            }
        }
        self.workItem = newWorkItem
        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(800), execute: newWorkItem)
    }
}
