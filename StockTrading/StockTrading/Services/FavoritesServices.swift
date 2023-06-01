//
//  FavoritesServices.swift
//  StockTrading
//
//  Created by Jason Liu on 5/2/22.
//

import Foundation

class FavoritesService {
    
    func getFavorites() -> [FavoriteObj] {
        let favoritesString = UserDefaults.standard.string(forKey: "favorites")
        if favoritesString == nil {
            return []
        }
        let favorites = try! JSONDecoder().decode([FavoriteObj].self, from: (favoritesString ?? "[]").data(using: .utf8)!)
        return favorites
    }
    
    func isStockInFavorites(symbol: String) -> Bool {
        let favorites = getFavorites()
        return favorites.contains{ $0.symbol == symbol }
    }
    
    func toggleFavoriteStatus(symbol: String?, name: String?, c: Float, d: Float, dp: Float) -> Int {
        if symbol == nil || name == nil {
            return -1
        }
        if !isStockInFavorites(symbol: symbol!) {
            addToFavorites(symbol: symbol!, name: name!, c: c, d: d, dp: dp)
            return 1
        } else {
            deleteFromFavorites(symbol: symbol!)
            return 0
        }
    }
    
    func addToFavorites(symbol: String, name: String, c: Float, d: Float, dp: Float) {
        var favorites = getFavorites()
        let favoriteObj = FavoriteObj(symbol: symbol, name: name, c: c, d: d, dp: dp)
        favorites.append(favoriteObj)
        updateFavorites(favorites: favorites)
    }
    
    func deleteFromFavorites(symbol: String) {
        let favorites = getFavorites()
        let filtered = favorites.filter{ $0.symbol != symbol}
        updateFavorites(favorites: filtered)
    }
    
    func updateFavorites(favorites: [FavoriteObj]) {
        print(favorites)
        let favoritesString = try! JSONEncoder().encode(favorites)
        UserDefaults.standard.set(String(data: favoritesString, encoding: .utf8), forKey: "favorites")
    }
    
    func clearFavorites() {
        UserDefaults.standard.removeObject(forKey: "favorites")
    }
}
