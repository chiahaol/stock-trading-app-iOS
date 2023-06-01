//
//  HomePageDateView.swift
//  StockTrading
//
//  Created by Jason Liu on 4/29/22.
//

import SwiftUI

struct HomePageDateView: View {
    
    @Environment(\.isSearching) var isSearching
    
    var body: some View {
        if isSearching == false {
            Section {
                Text(Date(), style: .date)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 8.0)
            }
        }
    }
}

struct HomePageDateView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageDateView()
    }
}
