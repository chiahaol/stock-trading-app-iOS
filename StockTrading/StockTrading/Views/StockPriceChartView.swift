//
//  StockPriceChartView.swift
//  StockTrading
//
//  Created by Jason Liu on 4/30/22.
//

import SwiftUI

struct StockPriceChartView: View {
    
    @EnvironmentObject private var companyProfileVM: CompanyProfileViewModel
    @EnvironmentObject private var quoteVM: QuoteViewModel
    
    var body: some View {
        TabView {
            HourlyChartView()
                .tabItem {
                   Label("Hourly", systemImage: "chart.xyaxis.line")
                }
            HistoricalChartView()
                .tabItem {
                   Label("Historical", systemImage: "clock.fill")
                }
        }
        .frame(height: 450.0)
    }
}

struct StockPriceChartView_Previews: PreviewProvider {
    static var previews: some View {
        StockPriceChartView()
    }
}
