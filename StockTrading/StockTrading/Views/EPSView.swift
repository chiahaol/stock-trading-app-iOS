//
//  EPSView.swift
//  StockTrading
//
//  Created by Jason Liu on 5/1/22.
//

import SwiftUI

struct EPSView: View {
    @EnvironmentObject private var companyProfileVM: CompanyProfileViewModel
    
    @State var title: String = "Recommendation Trend Chart"
    @State var error: Error? = nil
    
    var body: some View {
        WebView(title: $title, fileSource: "EPSChart", jsString: "getEPSChart('\(companyProfileVM.companyProfile?.ticker ?? "")')")
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
        .padding(.leading, -13.0)
        .frame(height: 450.0)
    }
}

struct EPSView_Previews: PreviewProvider {
    static var previews: some View {
        EPSView()
    }
}
