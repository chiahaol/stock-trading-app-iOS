//
//  PeersListView.swift
//  StockTrading
//
//  Created by Jason Liu on 5/1/22.
//

import SwiftUI

struct PeersListView: View {
    
    @EnvironmentObject private var companyProfileVM: CompanyProfileViewModel
    
    @State var peersList: [String] = []
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(peersList, id: \.self) { item in
                    NavigationLink(destination: SearchResultView(symbol: item)) {
                        Text("\(item),")
                            .font(.caption)
                    }
                }
            }
            
        }
        .onAppear() {
            Task.init {
                self.peersList = await WebServices().getPeers(symbol: companyProfileVM.companyProfile?.ticker ?? "")
            }
        }
    }
}

struct PeersListView_Previews: PreviewProvider {
    static var previews: some View {
        PeersListView()
    }
}
