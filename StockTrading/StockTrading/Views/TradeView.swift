//
//  TradeView.swift
//  StockTrading
//
//  Created by Jason Liu on 5/2/22.
//

import SwiftUI

struct TradeView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var companyProfileVM: CompanyProfileViewModel
    @EnvironmentObject private var quoteVM: QuoteViewModel
    @EnvironmentObject private var portfolioVM: PortfolioViewModel
    
    @State private var amount = ""
    @State private var sucess = false
    @State private var success_type = ""
    @State var haveError = false
    @State var errMsg = ""
    
    @Binding var portfolioObj: Portfolio?
    
    var body: some View {
        if sucess == false {
            VStack {
                HStack {
                    Spacer()
                    Button("\(Image(systemName: "xmark"))") {
                        dismiss()
                    }
                    .foregroundColor(.black)
                }
                Text("Trade \(companyProfileVM.companyProfile?.name ?? "") shares" )
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                HStack(alignment: .bottom) {
                    TextField("0", text: $amount)
                        .keyboardType(.numberPad)
                        .font(Font.system(size: 80, design: .default))
                    Spacer()
                    Text((Int(amount) ?? 0 > 1) ? "Shares" : "Share")
                        .font(.largeTitle)
                        .padding(.bottom, 20.0)
                }
                HStack {
                    Spacer()
                    Text(String(format: "x $%.2f/share = $%.2f", quoteVM.quote?.c ?? 0.00, (quoteVM.quote?.c ?? 0.00) * (Float(amount) ?? 0)))
                }
                
                Spacer()
                
                Text(String(format: "$%.2f vailable to buy \(companyProfileVM.companyProfile?.ticker ?? "")", PortfolioService().getCurrentMoney()))
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                    .padding(.bottom, 10.0)
                HStack {
                    Button {
                        let ret = PortfolioService().buyStock(symbol: self.companyProfileVM.companyProfile?.ticker, name: self.companyProfileVM.companyProfile?.name, currentPrice: self.quoteVM.quote?.c ?? 0.00, amountString: amount ?? "")
                        if ret == 0 {
                            self.portfolioObj = portfolioVM.getPortfolioObj(symbol: self.companyProfileVM.companyProfile?.ticker)
                            sucess.toggle()
                            success_type = "bought"
                        } else {
                            if ret == -1 {
                                errMsg = "Cannot buy non-positive shares"
                            } else if ret == -2 {
                                errMsg = "Not enough money to buy"
                            } else if ret == -3 {
                                errMsg = "Please enter a valid amount"
                            }
                            withAnimation {
                                haveError = true
                            }
                        }
                    } label: {
                        Text("Buy")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 60.0)
                            .padding(.vertical, 16.0)
                    }
                    .foregroundColor(.white)
                    .background(Color(red: 0.178, green: 0.772, blue: 0.32))
                    .clipShape(Capsule())
                    
                    Spacer()
                    
                    Button {
                        let ret = PortfolioService().sellStock(symbol: self.companyProfileVM.companyProfile?.ticker, currentPrice: self.quoteVM.quote?.c ?? 0.00, amountString: amount ?? "")
                        if ret == 0 {
                            self.portfolioObj = portfolioVM.getPortfolioObj(symbol: self.companyProfileVM.companyProfile?.ticker)
//                            portfolioVM.fetchLatest()
                            sucess.toggle()
                            success_type = "sold"
                        } else {
                            if ret == -1 {
                                errMsg = "Cannot sell non-positive shares"
                            } else if ret == -2 {
                                errMsg = "Not enough shares to sell"
                            } else if ret == -3 {
                                errMsg = "Please enter a valid amount"
                            }
                            withAnimation {
                                haveError = true
                            }
                        }
                    } label: {
                        Text("Sell")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 60.0)
                            .padding(.vertical, 16.0)
                    }
                    .foregroundColor(.white)
                    .background(Color(red: 0.178, green: 0.772, blue: 0.32))
                    .clipShape(Capsule())
                }
            }
            .padding(.horizontal, 20.0)
            .padding(.vertical, 20.0)
            .toast(isShowing: $haveError, text: Text(errMsg))
        } else {
            VStack {
                Spacer()
                Text("Congratulations!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 20.0)
                Text("You have successfully \(self.success_type) \(amount) \((Int(amount) ?? 0) > 1 ? "shares" : "share") of \(companyProfileVM.companyProfile?.ticker ?? "") ")
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30.0)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text("Done")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 160.0)
                        .padding(.vertical, 16.0)
                }
                .foregroundColor(Color(red: 0.178, green: 0.772, blue: 0.32))
                .background(.white)
                .clipShape(Capsule())
            }
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.178, green: 0.772, blue: 0.32))
        }
    }
}

//struct TradeView_Previews: PreviewProvider {
//    static var previews: some View {
//        TradeView()
//    }
//}
