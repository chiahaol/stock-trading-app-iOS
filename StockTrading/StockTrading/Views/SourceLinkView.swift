//
//  SourceLinkView.swift
//  StockTrading
//
//  Created by Jason Liu on 5/3/22.
//

import SwiftUI

struct SourceLinkView: View {
    
    @Environment(\.isSearching) var isSearching
    
    var body: some View {
        if isSearching == false {
            Section {
                HStack {
                    Spacer()
                    Text("[Powered by Finnhub.io](https://www.finnhub.io/)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .accentColor(.gray)
                    Spacer()
                }
            }
        }
    }
}

struct SourceLinkView_Previews: PreviewProvider {
    static var previews: some View {
        SourceLinkView()
    }
}
