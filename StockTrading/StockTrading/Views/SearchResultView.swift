//
//  SearchResultView.swift
//  StockTrading
//
//  Created by Jason Liu on 4/29/22.
//

import SwiftUI

struct SearchResultView: View {
    
    @StateObject private var companyProfileVM = CompanyProfileViewModel()
    @StateObject private var quoteVM = QuoteViewModel()
    var symbol: String
    var isLoading: Bool = false
    @State var isFavorite = false
    @State var favoritePressed = false
    @State var title: String = ""
    @State var error: Error? = nil
    
    var body: some View {
            VStack {
                if companyProfileVM.companyProfile != nil && quoteVM.quote != nil {
                    
                    ScrollView {
                        VStack {
                            StockBasicInfoView()
                                .environmentObject(self.companyProfileVM)
                                .environmentObject(self.quoteVM)
                            
                            StockPriceChartView()
                                .environmentObject(self.companyProfileVM)
                                .environmentObject(self.quoteVM)
                            
                            StockPortfolioView()
                                .environmentObject(self.companyProfileVM)
                                .environmentObject(self.quoteVM)
                            
                            StatsView()
                                .environmentObject(self.quoteVM)
                            
                            AboutView()
                                .environmentObject(self.companyProfileVM)
                            
                            InsightsView()
                                .environmentObject(self.companyProfileVM)
                            
                            TopNewsView()
                                .environmentObject(self.companyProfileVM)
                        }
                    }
                    .navigationBarTitle(symbol)
                    .navigationViewStyle(.stack)
                    .navigationBarItems(
                        trailing:
                            Button("\(Image(systemName: isFavorite ? "plus.circle.fill" : "plus.circle"))") {
                                let ret = FavoritesService().toggleFavoriteStatus(symbol: companyProfileVM.companyProfile?.ticker, name: companyProfileVM.companyProfile?.name, c: quoteVM.quote?.c ?? 0, d: quoteVM.quote?.d ?? 0, dp: quoteVM.quote?.dp ?? 0)
                                
                                if ret >= 0 {
                                    isFavorite.toggle()
                                    withAnimation {
                                        favoritePressed = true
                                    }
                                }
                            }
                    )
                } else {
                    ProgressView("Fetching Data...")
                }
            }
            .onAppear() {
                Task.init {
                    await self.companyProfileVM.getCompanyProfile(symbol: self.symbol)
                    await self.quoteVM.getQuote(symbol: self.symbol)
                    self.isFavorite = FavoritesService().isStockInFavorites(symbol: self.companyProfileVM.companyProfile?.ticker ?? "")
                }
            }
            .toast(isShowing: $favoritePressed, text: Text(isFavorite ? "Adding \(companyProfileVM.companyProfile?.ticker ?? "") to Favorites" : "Removing \(companyProfileVM.companyProfile?.ticker ?? "") from Favorites"))
        }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(symbol: "AAPL")
    }
}
