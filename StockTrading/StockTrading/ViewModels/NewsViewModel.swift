//
//  NewsViewModel.swift
//  StockTrading
//
//  Created by Jason Liu on 5/1/22.
//

import Foundation

@MainActor
class NewsViewModel :ObservableObject {
    @Published var news: [News] = []
    
    func getNews(symbol: String) async {
        let newsResponse = await WebServices().getNews(symbol: symbol)
        self.news = filterNews(newsResponse: newsResponse)
    }
    
    func filterNews(newsResponse: [News]) -> [News] {
        var filtered: [News] = []
        for newsObj in newsResponse {
            if newsObj.headline != "" && newsObj.url != "" && newsObj.image != "" && newsObj.headline != "" {
                filtered.append(newsObj)
            }
            if filtered.count >= 20 {
                break
            }
        }
        return filtered
    }
    
    func calculateTimeSincePublished(publishedTimestamp: Int) -> String {
        let now = Date().timeIntervalSince1970
        let diff = Int(now) - publishedTimestamp
        let hour = diff / 3600
        let minute = (diff % 3600) / 60
        
        return "\(hour) hr, \(minute) min"
    }
    
    func getDateTimeString(publishedTimestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(publishedTimestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.string(from: date)
    }
}
