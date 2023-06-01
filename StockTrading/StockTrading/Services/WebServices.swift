//
//  WebServices.swift
//  StockTrading
//
//  Created by Jason Liu on 4/29/22.
//

import Foundation


class WebServices {
    
    func getCompanyProfile (symbol: String) async -> CompanyProfile? {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "csci571hw8-chiahaol.appspot.com"
        urlComponent.path = "/finnhub/profile"
        urlComponent.queryItems = [
            URLQueryItem(name: "symbol", value: symbol)
        ]
        
        guard let url = urlComponent.url else {
            return nil
        }
        print(url)
        var companyProfile: CompanyProfile?
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            companyProfile = try? JSONDecoder().decode(CompanyProfile.self, from: data)
        } catch {
            return nil
        }
        
        return companyProfile ?? nil;
    }
    
    func getAutocomplete (symbol: String) async -> AutocompleteResponse? {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "csci571hw8-chiahaol.appspot.com"
        urlComponent.path = "/finnhub/autocomplete"
        urlComponent.queryItems = [
            URLQueryItem(name: "queryString", value: symbol)
        ]
       
        guard let url = urlComponent.url else {
            return nil
        }
        print(url)
        var autocompleteResponse: AutocompleteResponse?
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            autocompleteResponse = try? JSONDecoder().decode(AutocompleteResponse.self, from: data)
        } catch {
            return nil
        }
        
        return autocompleteResponse ?? nil;
    }
    
    func getQuote (symbol: String) async -> QuoteResponse? {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "csci571hw8-chiahaol.appspot.com"
        urlComponent.path = "/finnhub/quote"
        urlComponent.queryItems = [
            URLQueryItem(name: "symbol", value: symbol)
        ]
        
        guard let url = urlComponent.url else {
            return nil
        }
        print(url)
        var quoteResponse: QuoteResponse?
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            quoteResponse = try? JSONDecoder().decode(QuoteResponse.self, from: data)
        } catch {
            return nil
        }
        
        return quoteResponse ?? nil;
    }
    
    func getPeers (symbol: String) async -> [String] {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "csci571hw8-chiahaol.appspot.com"
        urlComponent.path = "/finnhub/peers"
        urlComponent.queryItems = [
            URLQueryItem(name: "symbol", value: symbol)
        ]
        
        guard let url = urlComponent.url else {
            return []
        }
        print(url)
        var peersResponse: [String]? = []
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            peersResponse = try? JSONDecoder().decode([String].self, from: data)
        } catch {
            return []
        }
        
        return peersResponse ?? []
    }
    
    func getSocialSentiment (symbol: String) async -> SocialSentimentsResponse? {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "csci571hw8-chiahaol.appspot.com"
        urlComponent.path = "/finnhub/socialSentiment"
        urlComponent.queryItems = [
            URLQueryItem(name: "symbol", value: symbol)
        ]
        
        guard let url = urlComponent.url else {
            return nil
        }
        print(url)
        var socialSentimentsResponse: SocialSentimentsResponse?
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            socialSentimentsResponse = try? JSONDecoder().decode(SocialSentimentsResponse.self, from: data)
        } catch {
            return nil
        }
        
        return socialSentimentsResponse ?? nil
    }
    
    func getNews(symbol: String) async -> [News] {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "csci571hw8-chiahaol.appspot.com"
        urlComponent.path = "/finnhub/news"
        urlComponent.queryItems = [
            URLQueryItem(name: "symbol", value: symbol)
        ]
        
        guard let url = urlComponent.url else {
            return []
        }
        print(url)
        var newsResponse: [News]? = []
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            newsResponse = try? JSONDecoder().decode([News].self, from: data)
        } catch {
            return []
        }
        
        return newsResponse ?? []
    }
}
