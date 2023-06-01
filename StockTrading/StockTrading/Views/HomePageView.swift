//
//  HomePageView.swift
//  StockTrading
//
//  Created by Jason Liu on 4/29/22.
//

import SwiftUI

struct HomePageView: View {
    
    @StateObject private var autocompleteListVM = AutocompleteListViewModel()
    @StateObject var portfolioVM = PortfolioViewModel()
    @StateObject var favoritesVM = FavoritesViewModel()
    
    @State var portfolios: [Portfolio] = []
    @State var favorites: [FavoriteObj] = []
    @State private var symbol = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.secondarySystemBackground)
                    .edgesIgnoringSafeArea(.all)
                
                List {
                    HomePageDateView()
//                        .onAppear() {
//                            FavoritesService().clearFavorites()
//                            PortfolioService().clearPortfolio()
//                            PortfolioService().clearCurrentMoney()
//                        }
                    PortfolioView()
                        .onAppear() {
                            portfolioVM.fetchLatest()
                        }
                    
                    FavoritesView()
                        .onAppear() {
                            favoritesVM.fetchLastest()
                        }
                    
                    SourceLinkView()
                    
                    SearchSuggestionView()
                        .environmentObject(self.autocompleteListVM)
                }
                .frame(maxWidth: .infinity)
                .listStyle(InsetGroupedListStyle())
                .opacity((portfolioVM.initialLoad && favoritesVM.initialLoad) ? 1 : 0)
                
                ProgressView("Fetching Data...")
                    .opacity((!portfolioVM.initialLoad || !favoritesVM.initialLoad) ? 1 : 0)
            }
            .navigationBarTitle("Stocks")
            .navigationBarItems(
                trailing:
                    EditButton()
            )
        }
        .environmentObject(portfolioVM)
        .environmentObject(favoritesVM)
        .searchable(text: $symbol) {}
        .onChange(of: symbol) { query in
            Task.init {
                await autocompleteListVM.getAutocompleteList(symbol: self.symbol)
            }
        }
        .onSubmit(of: .search) {
            Task.init {
                await autocompleteListVM.getAutocompleteList(symbol: self.symbol)
            }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
