//
//  FavoritesViewModel.swift
//  StockTrading
//
//  Created by Jason Liu on 5/3/22.
//

import Foundation


class FavoritesViewModel :ObservableObject {
    @Published var favorites: [FavoriteObj] = []
    @Published var initialLoad: Bool = false
    var timer: Timer?

    init() {
        Task.init {
           await self.refresh()
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 15, repeats: true, block: { _ in
            Task.init {
                await self.refresh()
            }
        })
    }
    deinit {
        timer?.invalidate()
    }

    func refresh() async {
        self.fetchLastest()
        let group = DispatchGroup()
        for (index, favoriteObj) in self.favorites.enumerated() {
            group.enter()
            DispatchQueue.global().async {
                Task.init {
                    let quoteResponse = await WebServices().getQuote(symbol: favoriteObj.symbol)
                    DispatchQueue.main.async {
                        self.favorites[index].c = quoteResponse?.c ?? self.favorites[index].c
                        self.favorites[index].d = quoteResponse?.d ?? self.favorites[index].d
                        self.favorites[index].dp = quoteResponse?.dp ?? self.favorites[index].dp
                        group.leave()
                    }
                }
            }
        }
        
        group.notify(queue: .main) {
            FavoritesService().updateFavorites(favorites: self.favorites)
            self.initialLoad = true
            print("favorites refreshed")
        }
    }
    
    func fetchLastest() {
        DispatchQueue.main.async {
            self.favorites = FavoritesService().getFavorites()
        }
    }
}
