//
//  SocialSentimentsViewModel.swift
//  StockTrading
//
//  Created by Jason Liu on 5/1/22.
//

import Foundation

@MainActor
class SocialSentimentsViewModel: ObservableObject {
    
    @Published var socialSentimentsResponse: SocialSentimentsResponse? = nil
    @Published var redditData: [Int] = [0, 0, 0]
    @Published var twitterData: [Int] = [0, 0, 0]
    
    func getSocialSentiments(symbol: String) async {
        self.socialSentimentsResponse = await WebServices().getSocialSentiment(symbol: symbol)
        makeRedditData()
        makeTwitterData()
    }
    
    func makeRedditData() {
        for sentimentObj in self.socialSentimentsResponse?.reddit ?? [] {
            redditData[0] += sentimentObj.mention
            redditData[1] += sentimentObj.positiveMention
            redditData[2] += sentimentObj.negativeMention
        }
    }
    
    func makeTwitterData() {
        for sentimentObj in self.socialSentimentsResponse?.twitter ?? [] {
            twitterData[0] += sentimentObj.mention
            twitterData[1] += sentimentObj.positiveMention
            twitterData[2] += sentimentObj.negativeMention
        }
    }
}
