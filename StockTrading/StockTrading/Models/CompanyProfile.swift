//
//  CompanyProfile.swift
//  StockTrading
//
//  Created by Jason Liu on 4/29/22.
//

import Foundation

struct CompanyProfile: Codable {
    let country: String
    let currency: String
    let exchange: String
    let name: String
    let ticker: String
    let ipo: String
    let marketCapitalization: Float
    let shareOutstanding: Float
    let logo: String
    let phone: String
    let weburl: String
    let finnhubIndustry: String
}
