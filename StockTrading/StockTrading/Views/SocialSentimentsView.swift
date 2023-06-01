//
//  SocialSentimentsView.swift
//  StockTrading
//
//  Created by Jason Liu on 5/1/22.
//

import SwiftUI

struct SocialSentimentsView: View {
    
    @EnvironmentObject private var companyProfileVM: CompanyProfileViewModel
    @StateObject var socialSentimentsVM = SocialSentimentsViewModel()
    
    var body: some View {
        VStack {
            Text("Social Sentiments")
                .font(.title3)
                .fontWeight(.semibold)
            
            HStack {
                List {
                    Text("\(companyProfileVM.companyProfile?.name ?? "")")
                        .fontWeight(.bold)
                        .lineLimit(2)
                    Text("Total Mentions")
                        .fontWeight(.bold)
                    Text("Positive Mentions")
                        .fontWeight(.bold)
                    Text("Negative Mentions")
                        .fontWeight(.bold)
                }
                .font(.subheadline)
                .environment(\.defaultMinListRowHeight, 60)
                .listStyle(PlainListStyle())
                
                
                List {
                    Text("Reddit")
                        .fontWeight(.bold)
                    Text("\(socialSentimentsVM.redditData[0])")
                    Text("\(socialSentimentsVM.redditData[1])")
                    Text("\(socialSentimentsVM.redditData[2])")
                }
                .font(.subheadline)
                .environment(\.defaultMinListRowHeight, 60)
                .listStyle(PlainListStyle())
                
                List {
                    Text("Twitter")
                        .fontWeight(.bold)
                    Text("\(socialSentimentsVM.twitterData[0])")
                    Text("\(socialSentimentsVM.twitterData[1])")
                    Text("\(socialSentimentsVM.twitterData[2])")
                }
                .font(.subheadline)
                .environment(\.defaultMinListRowHeight, 60)
                .listStyle(PlainListStyle())
            }
            .padding(.leading, -13.0)
            .frame(height: 250.0)
        }
        .onAppear() {
            Task.init {
                await self.socialSentimentsVM.getSocialSentiments(symbol: companyProfileVM.companyProfile?.ticker ?? "")
            }
        }
    }
}

struct SocialSentimentsView_Previews: PreviewProvider {
    static var previews: some View {
        SocialSentimentsView()
    }
}
