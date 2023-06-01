//
//  TopNewsView.swift
//  StockTrading
//
//  Created by Jason Liu on 5/1/22.
//

import SwiftUI
import Kingfisher

struct TopNewsView: View {
    
    @EnvironmentObject private var companyProfileVM: CompanyProfileViewModel
    @StateObject var newsVM = NewsViewModel()
    @State private var showingSheet = false
    @State var tappedNews: News? = nil
    
    var body: some View {
        VStack {
            HStack {
                Text("News")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            if newsVM.news.count > 0 {
                VStack {
                    VStack {
                        
                        KFImage(URL(string: newsVM.news[0].image) ?? URL(string: newsVM.news[0].image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 320, height: 190)
                            .cornerRadius(8.0)
                        
                            
                        HStack {
                            Text("\(newsVM.news[0].source) \(newsVM.calculateTimeSincePublished(publishedTimestamp: newsVM.news[0].datetime))")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.gray)
                                .padding(.bottom, 3.0)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text(newsVM.news[0].headline)
                                .font(.headline)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .onTapGesture {
                        self.showingSheet.toggle()
                        tappedNews = newsVM.news[0]
                    }
                    .sheet(isPresented: $showingSheet) {
                        ShareNewsView(news: $tappedNews)
                            .environmentObject(newsVM)
                    }
                    
                    Divider()
                    
                    ForEach(newsVM.news[1...], id: \.id) { item in
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                Text("\(item.source) \(newsVM.calculateTimeSincePublished(publishedTimestamp: item.datetime))")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.gray)
                                    .padding(.bottom, 3.0)
                                Text(item.headline)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            }
                            
                            Spacer()
                            
                            KFImage(URL(string: item.image) ?? URL(string: item.image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70.0, height: 70.0)
                                .cornerRadius(8.0)
                                
                        }
                        .padding(.vertical, 5.0)
                        .onTapGesture {
                            self.showingSheet.toggle()
                            tappedNews = item
                        }
                        .sheet(isPresented: $showingSheet) {
                            ShareNewsView(news: $tappedNews)
                                .environmentObject(newsVM)
                        }
                       
                    }
                }
            }
        }
        .padding(.horizontal, 25.0)
        .padding(.top, 10.0)
        .onAppear() {
            Task.init {
                await newsVM.getNews(symbol: companyProfileVM.companyProfile?.ticker ?? "")
            }
        }
    }
}

//struct TopNewsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopNewsView()
//    }
//}
