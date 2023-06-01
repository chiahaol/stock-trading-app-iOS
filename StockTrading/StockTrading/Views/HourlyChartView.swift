//
//  HourlyChartView.swift
//  StockTrading
//
//  Created by Jason Liu on 4/30/22.
//

import SwiftUI

struct HourlyChartView: View {
    @EnvironmentObject private var companyProfileVM: CompanyProfileViewModel
    @EnvironmentObject private var quoteVM: QuoteViewModel
    
    @State var title: String = "Hourly Chart"
    @State var error: Error? = nil

    var body: some View {
        WebView(title: $title, fileSource: "HourlyChart", jsString: "getHourlyChart('\(companyProfileVM.companyProfile?.ticker ?? "")', \(quoteVM.quote?.t ?? Int( Date().timeIntervalSince1970)), '\((quoteVM.quote?.d ?? 0 >= 0) ? "#048004" : "#df7676")')")
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

struct HourlyChartView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyChartView()
    }
}
