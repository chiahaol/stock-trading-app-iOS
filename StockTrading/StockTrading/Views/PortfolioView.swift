//
//  PortfolioView.swift
//  StockTrading
//
//  Created by Jason Liu on 4/29/22.
//

import SwiftUI

struct PortfolioView: View {
    
    @Environment(\.isSearching) var isSearching
    @EnvironmentObject private var portfolioVM: PortfolioViewModel
    
    var body: some View {
        if isSearching == false {
            Section(header: Text("PORTFOLIO")) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Net Worth")
                            .font(.title2)
                        Text(String(format: "$%.2f", portfolioVM.netWorth))
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Cash Balance")
                            .font(.title2)
                        Text(String(format: "$%.2f", PortfolioService().getCurrentMoney()))
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                }
                
                ForEach(portfolioVM.portfolios, id: \.symbol) { item in
                    NavigationLink(destination: SearchResultView(symbol: item.symbol)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.symbol)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text("\(item.amount) \(item.amount > 1 ? "shares" : "share")")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(red: 0.611, green: 0.61, blue: 0.631))
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text(String(format: "$%.2f", portfolioVM.getMarketValue(portfolioObj: item)))
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                if portfolioVM.getChange(portfolioObj: item) > 0 {
                                    Text("\(Image(systemName: "arrow.up.right"))  \(String(format: "%.2f (%.2f)", portfolioVM.getChange(portfolioObj: item), portfolioVM.getChangePercentage(portfolioObj: item)))")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 0.178, green: 0.772, blue: 0.32))
                                } else if portfolioVM.getChange(portfolioObj: item) < 0 {
                                    Text("\(Image(systemName: "arrow.down.right"))  \(String(format: "%.2f  (%.2f)", portfolioVM.getChange(portfolioObj: item), portfolioVM.getChangePercentage(portfolioObj: item)))")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 0.998, green: 0.233, blue: 0.188))
                                } else {
                                    Text("\(String(format: "%.2f  (%.2f)", portfolioVM.getChange(portfolioObj: item), portfolioVM.getChangePercentage(portfolioObj: item)))")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.black)
                                }
                                
                            }
                        }
                    }
                }
                .onMove { (indexSet, index) in
                    portfolioVM.movePortfolio(fromIndex: indexSet, toIndex: index)
                }
            }
        }
    }
}

//struct PortfolioView_Previews: PreviewProvider {
//    static var previews: some View {
//        PortfolioView()
//    }
//}
