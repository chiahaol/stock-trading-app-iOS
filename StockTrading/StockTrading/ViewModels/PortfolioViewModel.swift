//
//  PortfolioViewModel.swift
//  StockTrading
//
//  Created by Jason Liu on 5/1/22.
//

import Foundation


class PortfolioViewModel :ObservableObject {
    @Published var portfolios: [Portfolio] = PortfolioService().getPortfolio()
    @Published var netWorth: Float = PortfolioService().getNetWorth()
    @Published var initialLoad: Bool = false
    
//    private var portfolioSemaphore = DispatchSemaphore(value: 1)
    var timer: Timer?

    init() {
        Task.init {
           await self.refresh()
        }
        
        portfolios = PortfolioService().getPortfolio()
        timer = Timer.scheduledTimer(withTimeInterval: 15, repeats: true, block: { _ in
            Task.init {
                await self.refresh()
            }
        })
    }
    deinit {
        timer?.invalidate()
    }
    
    func refresh() async {
        self.fetchLatest()
        let group = DispatchGroup()
        for (index, portfolioObj) in portfolios.enumerated() {
            group.enter()
            DispatchQueue.global().async {
                Task.init {
                    let quoteResponse = await WebServices().getQuote(symbol: portfolioObj.symbol)
                    DispatchQueue.main.async {
                        self.portfolios[index].currentPrice = quoteResponse?.c ?? self.portfolios[index].currentPrice
                        group.leave()
                    }
                }
            }
        }
        group.notify(queue: .main) {
            PortfolioService().updatePortfolio(portfolio: self.portfolios)
            self.netWorth = PortfolioService().getNetWorth()
            self.initialLoad = true
            print("portfolio refreshed")
        }
        
    }
    
    func fetchLatest() {
        DispatchQueue.main.async {
            self.portfolios = PortfolioService().getPortfolio()
        }
    }
    
    func movePortfolio(fromIndex: IndexSet, toIndex: Int) {
//        self.portfolioSemaphore.wait()
        DispatchQueue.main.async {
            self.portfolios.move(fromOffsets: fromIndex, toOffset: toIndex)
            PortfolioService().updatePortfolio(portfolio: self.portfolios)
        }
//        self.portfolioSemaphore.signal()
    }
    
    func getPortfolioObj(symbol: String?) -> Portfolio? {
        return PortfolioService().getPortfolioObj(symbol: symbol)
    }
    
    func getSharedOwned(portfolioObj: Portfolio?) -> Int {
        return portfolioObj?.amount ?? 0
    }
    
    func getAvgCost(portfolioObj: Portfolio?) -> Float {
        return (portfolioObj?.totalCost ?? 0) / Float(portfolioObj?.amount ?? 1)
    }
    
    func getTotalCost(portfolioObj: Portfolio?) -> Float {
        return portfolioObj?.totalCost ?? 0.0
    }
    
    func getChange(portfolioObj: Portfolio?) -> Float {
        return getMarketValue(portfolioObj: portfolioObj) - getTotalCost(portfolioObj: portfolioObj)
    }
    
    func getChangePercentage(portfolioObj: Portfolio?) -> Float {
        let totalCost =  getTotalCost(portfolioObj: portfolioObj)
        return (totalCost > 0) ? getChange(portfolioObj: portfolioObj) / totalCost : 0
    }
    
    func getMarketValue(portfolioObj: Portfolio?) -> Float {
        return (portfolioObj?.currentPrice ?? 0) * Float(getSharedOwned(portfolioObj: portfolioObj))
    }
}
