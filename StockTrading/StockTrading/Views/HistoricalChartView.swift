//
//  HistoricalChartView.swift
//  StockTrading
//
//  Created by Jason Liu on 5/1/22.
//

import SwiftUI

struct HistoricalChartView: View {
    @EnvironmentObject private var companyProfileVM: CompanyProfileViewModel
    @EnvironmentObject private var quoteVM: QuoteViewModel
    
    @State var title: String = "Historical Chart"
    @State var error: Error? = nil
    
    var body: some View {
        WebView(title: $title, fileSource: "HistoricalChart", jsString: "getHistoricalChart('\(companyProfileVM.companyProfile?.ticker ?? "")')")
            .onLoadStatusChanged { loading, error in
                if loading {
                    print("Loading started")
                    self.title = "Loading…"
                }
                else {
                    print("Done loading.")
                    if let error = error {
                        self.error = error
                        if self.title.isEmpty {
                            self.title = "Error"
                        }
                    }
                    else if self.title.isEmpty {
                        self.title = "Some Place"
                    }
                }
        }
    }
}

struct HistoricalChartView_Previews: PreviewProvider {
    static var previews: some View {
        HistoricalChartView()
    }
}
