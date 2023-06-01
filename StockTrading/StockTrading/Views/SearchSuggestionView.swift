//
//  SearchSuggestionView.swift
//  StockTrading
//
//  Created by Jason Liu on 4/29/22.
//

import SwiftUI

struct SearchSuggestionView: View {
    @EnvironmentObject private var autocompleteListVM: AutocompleteListViewModel
    @Environment(\.isSearching) var isSearching
    
    var body: some View {
        if isSearching {
            ForEach(autocompleteListVM.autocompleteList, id: \.symbol) { item in
                NavigationLink(destination: SearchResultView(symbol: item.symbol)) {
                    VStack {
                        Text(item.symbol)
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(item.description)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color(red: 0.611, green: 0.61, blue: 0.631))
                    }
                    .padding(.horizontal, 15.0)
                }
            }
        }
        
        EmptyView()
            .onChange(of: isSearching) { value in
                autocompleteListVM.workItem?.cancel()
                autocompleteListVM.autocompleteList = []
            }
    }
}

struct SearchSuggestionView_Previews: PreviewProvider {
    static var previews: some View {
        SearchSuggestionView()
    }
}
