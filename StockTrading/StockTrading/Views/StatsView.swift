//
//  StatsView.swift
//  StockTrading
//
//  Created by Jason Liu on 5/1/22.
//

import SwiftUI

struct StatsView: View {
    
    @EnvironmentObject private var quoteVM: QuoteViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Stats")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.bottom, 8.0)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("High Price: ")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text("\(String(format: "%.2f", quoteVM.quote?.h ?? 0))")
                            .font(.caption)
                    }
                    .padding(.bottom, 4.0)
                    
                    HStack {
                        Text("Low Price: ")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text("\(String(format: "%.2f", quoteVM.quote?.l ?? 0))")
                            .font(.caption)
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Open Price: ")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text("\(String(format: "%.2f", quoteVM.quote?.o ?? 0))")
                            .font(.caption)
                    }
                    .padding(.bottom, 4.0)
                    
                    HStack {
                        Text("Prev. Close: ")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text("\(String(format: "%.2f", quoteVM.quote?.pc ?? 0))")
                            .font(.caption)
                    }
                }
                .padding(.leading, 10.0)
            }
        }
        .padding(.horizontal, 25.0)
        .padding(.top, 10.0)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
