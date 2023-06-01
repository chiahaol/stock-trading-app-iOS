//
//  ShareNewsView.swift
//  StockTrading
//
//  Created by Jason Liu on 5/3/22.
//

import SwiftUI

struct ShareNewsView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var newsVm: NewsViewModel
    @Binding var news: News?
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("\(Image(systemName: "xmark"))") {
                    dismiss()
                }
                .foregroundColor(.black)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(news?.source ?? "")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(newsVm.getDateTimeString(publishedTimestamp: news?.datetime ?? Int(Date().timeIntervalSince1970)))
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.gray)
                        .padding(.bottom, 5.0)
                }
                Spacer()
            }
            
            Divider()
            
            HStack {
                VStack(alignment: .leading) {
                    Text(news?.headline ?? "")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text(news?.summary ?? "")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    HStack {
                        Text("For more details click")
                            .font(.footnote)
                            .foregroundColor(Color.gray)
                        Link("here", destination: URL(string: news?.url ?? "")!)
                            .font(.footnote)
                    }
                }
                .padding(.top, 5.0)
                
                Spacer()
            }
            .padding(.bottom, 5.0)
            
            HStack {
                Link(destination: URL(string: "https://twitter.com/intent/tweet?text=\(news?.headline ?? "")%0A&url=\(news?.url ?? "")".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!) {
                    Image("twitter.logo")
                        .resizable()
                        .frame(width: 50.0, height: 50.0)
                        .scaledToFill()
                }

                Link(destination: URL(string: "https://www.facebook.com/sharer/sharer.php?text=\(news?.headline ?? "")&u=\(news?.url ?? "")".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!) {
                    Image("facebook.logo")
                        .resizable()
                        .frame(width: 50.0, height: 50.0)
                        .scaledToFill()
                }
                
                Spacer()
            }
            
            Spacer()
        }
        .padding(.horizontal, 20.0)
        .padding(.vertical, 20.0)
        
        
    }
}

//struct ShareNewsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShareNewsView()
//    }
//}
