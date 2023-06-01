//
//  FavoritesView.swift
//  StockTrading
//
//  Created by Jason Liu on 4/29/22.
//

import SwiftUI

struct FavoritesView: View {
    
    @Environment(\.isSearching) var isSearching
    @EnvironmentObject var favoritesVM: FavoritesViewModel
    
    var body: some View {
        if isSearching == false {
            Section(header: Text("FAVORITES")) {
                ForEach(favoritesVM.favorites, id: \.symbol) { item in
                    NavigationLink(destination: SearchResultView(symbol: item.symbol)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.symbol)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text(item.name)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(red: 0.611, green: 0.61, blue: 0.631))
                                  
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text(String(format: "$%.2f", item.c))
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                if item.d >= 0 {
                                    Text("\(Image(systemName: "arrow.up.right"))  \(String(format: "%.2f (%.2f)", item.d, item.dp))")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 0.178, green: 0.772, blue: 0.32))
                                } else {
                                    Text("\(Image(systemName: "arrow.down.right"))  \(String(format: "%.2f (%.2f)", item.d, item.dp))")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 0.998, green: 0.233, blue: 0.188))
                                }
                                
                            }
                        }
                    }
                }
                .onMove { (indexSet, index) in
                    favoritesVM.favorites.move(fromOffsets: indexSet, toOffset: index)
                    FavoritesService().updateFavorites(favorites: favoritesVM.favorites)
                }
                .onDelete(perform: self.deleteFromFavoritesByIndex)
            }
        }
    }
    
    func deleteFromFavoritesByIndex(at indexSet: IndexSet) {
        favoritesVM.favorites.remove(atOffsets: indexSet)
        FavoritesService().updateFavorites(favorites: favoritesVM.favorites)
    }
}

//struct FavoritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesView()
//    }
//}

