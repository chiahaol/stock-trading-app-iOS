//
//  StockBasicInfoView.swift
//  StockTrading
//
//  Created by Jason Liu on 4/30/22.
//

import SwiftUI

struct StockBasicInfoView: View {
    
    @EnvironmentObject private var companyProfileVM: CompanyProfileViewModel
    @EnvironmentObject private var quoteVM: QuoteViewModel
    
    var body: some View {
        HStack {
            Text(companyProfileVM.companyProfile?.name ?? "")
                .font(.subheadline)
                .foregroundColor(Color(red: 0.611, green: 0.61, blue: 0.631))
            
            Spacer()
            
            AsyncImage(url: URL(string: companyProfileVM.companyProfile?.logo ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
            } placeholder: {
                ProgressView()
            }
            
        }
        .padding(.horizontal, 25.0)
        
        HStack {
            Text(String(format: "$%.2f", quoteVM.quote?.c ?? 0))
                .font(.title)
                .fontWeight(.semibold)
            if quoteVM.quote?.d ?? 0 > 0 {
                Text("\(Image(systemName: "arrow.up.right")) \(String(format: "%.2f (%.2f%%)", quoteVM.quote?.d ?? 0, quoteVM.quote?.dp ?? 0))")
                    .foregroundColor(Color(red: 0.178, green: 0.772, blue: 0.32))
            } else if quoteVM.quote?.d ?? 0 < 0 {
                Text("\(Image(systemName: "arrow.down.right")) \(String(format: "%.2f (%.2f%%)", quoteVM.quote?.d ?? 0, quoteVM.quote?.dp ?? 0))")
                    .foregroundColor(Color(red: 0.998, green: 0.233, blue: 0.188))
            } else {
                Text(String(format: "%.2f (%.2f%%)", quoteVM.quote?.d ?? 0, quoteVM.quote?.dp ?? 0))
            }
            
            Spacer()
        }
        .padding(.horizontal, 25.0)
    }
}

struct StockBasicInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StockBasicInfoView()
    }
}
