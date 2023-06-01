//
//  CompanyProfileViewModel.swift
//  StockTrading
//
//  Created by Jason Liu on 4/29/22.
//

import Foundation

//@MainActor
class CompanyProfileViewModel :ObservableObject {
    @Published var companyProfile: CompanyProfile? = nil
    
    func getCompanyProfile(symbol: String) async {
        self.companyProfile = await WebServices().getCompanyProfile(symbol: symbol)
    }
}
