//
//  StockPortfolioView.swift
//  StockTrading
//
//  Created by Jason Liu on 5/1/22.
//

import SwiftUI

struct StockPortfolioView: View {
    @EnvironmentObject private var companyProfileVM: CompanyProfileViewModel
    @EnvironmentObject private var quoteVM: QuoteViewModel
    @EnvironmentObject private var portfolioVM: PortfolioViewModel
    
    @State var portfolioObj: Portfolio?
    @State private var showingSheet = false
    
    var body: some View {
        HStack {
            Text("Portfolio")
                .font(.title3)
                .fontWeight(.semibold)
            
            Spacer()
        }
        .padding(.leading, 25.0)
        .padding(.top, 10.0)
       
        HStack(alignment: .center) {
            if portfolioVM.getSharedOwned(portfolioObj: self.portfolioObj) > 0 {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Shares Owned: ")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text("\(portfolioVM.getSharedOwned(portfolioObj: self.portfolioObj))")
                            .font(.caption)
                    }
                    .padding(.bottom, 4.0)
                    HStack {
                        Text("Avg. Cost/Share: ")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text("\(String(format: "$%.2f", portfolioVM.getAvgCost(portfolioObj: self.portfolioObj)))")
                            .font(.caption)
                    }
                    .padding(.bottom, 4.0)
                    HStack {
                        Text("Total Cost: ")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text("\(String(format: "$%.2f", portfolioVM.getTotalCost(portfolioObj: self.portfolioObj)))")
                            .font(.caption)
                    }
                    .padding(.bottom, 4.0)
                    HStack {
                        Text("Change: ")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text("\(String(format: "$%.2f", portfolioVM.getChange(portfolioObj: self.portfolioObj)))")
                            .font(.caption)
                            .foregroundColor((portfolioVM.getChange(portfolioObj: self.portfolioObj) > 0) ? Color(red: 0.178, green: 0.772, blue: 0.32) : (portfolioVM.getChange(portfolioObj: self.portfolioObj) < 0) ? Color(red: 0.998, green: 0.233, blue: 0.188) : Color.black)
                    }
                    .padding(.bottom, 4.0)
                    HStack {
                        Text("Market Value: ")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text("\(String(format: "$%.2f", portfolioVM.getMarketValue(portfolioObj: self.portfolioObj)))")
                            .font(.caption)
                            .foregroundColor((portfolioVM.getChange(portfolioObj: self.portfolioObj) > 0) ? Color(red: 0.178, green: 0.772, blue: 0.32) : (portfolioVM.getChange(portfolioObj: self.portfolioObj) < 0) ? Color(red: 0.998, green: 0.233, blue: 0.188) : Color.black)
                    }
                }
            } else {
                VStack(alignment: .leading) {
                    Text("You have 0 shares of \(companyProfileVM.companyProfile?.ticker ?? "").")
                    Text("Start trading!")
                }
            }
            Spacer()
            
            Button {
                showingSheet.toggle()
            } label: {
                Text("Trade")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.horizontal, 40.0)
                    .padding(.vertical, 14.0)
            }
            .foregroundColor(.white)
            .background(Color(red: 0.178, green: 0.772, blue: 0.32))
            .clipShape(Capsule())
            .sheet(isPresented: $showingSheet) {
                TradeView(portfolioObj: $portfolioObj)
                    .environmentObject(portfolioVM)
            }
        }
        .padding(.horizontal, 25.0)
        .frame(maxWidth: .infinity)
        .onAppear() {
            self.portfolioObj =  self.portfolioVM.getPortfolioObj(symbol: companyProfileVM.companyProfile?.ticker)
        }
    }
}

//struct StockPortfolioView_Previews: PreviewProvider {
//    static var previews: some View {
//        StockPortfolioView()
//    }
//}
