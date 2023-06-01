//
//  InsightsView.swift
//  StockTrading
//
//  Created by Jason Liu on 5/1/22.
//

import SwiftUI

struct InsightsView: View {
    
    @EnvironmentObject private var companyProfileVM: CompanyProfileViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Insights")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.bottom, 8.0)
            
            VStack {
                SocialSentimentsView()
                RecommendationTrendView()
                EPSView()
            }
        }
        .padding(.horizontal, 25.0)
        .padding(.top, 10.0)
       
    }
}

struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView()
    }
}
