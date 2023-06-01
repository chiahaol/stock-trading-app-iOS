//
//  AboutView.swift
//  StockTrading
//
//  Created by Jason Liu on 5/1/22.
//

import SwiftUI

struct AboutView: View {
    
    @EnvironmentObject private var companyProfileVM: CompanyProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("About")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.bottom, 8.0)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("IPO Start Date:")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.bottom, 4.0)
                    Text("Industry:")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.bottom, 4.0)
                    Text("Webpage:")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.bottom, 4.0)
                    Text("Company Peers:")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.bottom, 4.0)
                }
                
                VStack(alignment: .leading) {
                    Text(companyProfileVM.companyProfile?.ipo ?? "")
                        .font(.caption)
                        .padding(.bottom, 4.0)
                    Text(companyProfileVM.companyProfile?.finnhubIndustry ?? "")
                        .font(.caption)
                        .padding(.bottom, 4.0)
                    
                        ScrollView(.horizontal) {
                            if (companyProfileVM.companyProfile?.weburl ?? "") != "" {
                                Link(companyProfileVM.companyProfile?.weburl ?? "", destination: URL(string: companyProfileVM.companyProfile?.weburl ?? "")!)
                            } else {
                                Text(companyProfileVM.companyProfile?.weburl ?? "")
                            }
                               
                        }
                        .font(.caption)
                        .padding(.bottom, 4.0)
                    
                    PeersListView()
                }
                .padding(.leading, 10.0)
            }
        }
        .padding(.horizontal, 25.0)
        .padding(.top, 10.0)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
