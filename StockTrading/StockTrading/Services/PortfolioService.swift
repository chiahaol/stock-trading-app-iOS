//
//  PortfolioService.swift
//  StockTrading
//
//  Created by Jason Liu on 5/1/22.
//

import Foundation


class PortfolioService {
    func getPortfolioObj(symbol:  String?) -> Portfolio? {
        let portfolio = getPortfolio()
        let index = getIndexOfStock(symbol: symbol, portfolio: portfolio)
        return (index != -1) ? portfolio[index] : nil
    }
    
    func getPortfolio() -> [Portfolio] {
        let portfolioString = UserDefaults.standard.string(forKey: "portfolio")
        if portfolioString == nil {
            return []
        }
        let portfolio = try! JSONDecoder().decode([Portfolio].self, from: (portfolioString ?? "[]").data(using: .utf8)!)
        return portfolio
    }
    
    func buyStock(symbol: String?, name: String?, currentPrice: Float, amountString: String) -> Int {
        if symbol == nil || Int(amountString) == nil {
            return -3
        }
        let amount = Int(amountString) ?? 0
        if amount <= 0 {
            return -1
        }
        var currentMoney = getCurrentMoney()
        if currentMoney < Float(amount) * currentPrice {
            return -2
        }
        
        var portfolio = getPortfolio()
        var portfolioObj: Portfolio
        let index = getIndexOfStock(symbol: symbol, portfolio: portfolio)
        if index == -1 {
            portfolioObj = createNewPortfolioObj(symbol: symbol, name: name, currentPrice: currentPrice)
        } else {
            portfolioObj = portfolio[index]
        }
        
        portfolioObj.totalCost += Float(amount) * currentPrice
        portfolioObj.amount += amount
        portfolioObj.currentPrice = currentPrice
        currentMoney -= Float(amount) * currentPrice
        if index == -1 {
            portfolio.append(portfolioObj)
        } else {
            portfolio[index] = portfolioObj
        }
        updateCurrentMoney(currentMoney: currentMoney)
        updatePortfolio(portfolio: portfolio)
        return 0
    }
    
    func sellStock(symbol: String?, currentPrice: Float, amountString: String) -> Int {
        if symbol == nil || Int(amountString) == nil {
            return -3
        }
        let amount = Int(amountString) ?? 0
        if amount <= 0 {
            return -1
        }
        var portfolio = getPortfolio()
        var portfolioObj: Portfolio
        let index = getIndexOfStock(symbol: symbol, portfolio: portfolio)
        if index == -1 {
            return -2;
        }
        portfolioObj = portfolio[index]
        if portfolioObj.amount < amount {
            return -2
        }
        portfolioObj.amount -= amount
        portfolioObj.totalCost -= currentPrice * Float(amount)
        portfolioObj.currentPrice = currentPrice
        if portfolioObj.amount == 0 {
            deleteStockFromPortfolioByIndex(index: index)
        } else {
            portfolio[index] = portfolioObj
            updatePortfolio(portfolio: portfolio)
        }
        let currentMoney = getCurrentMoney()
        updateCurrentMoney(currentMoney: currentMoney + currentPrice * Float(amount))
        
        return 0
    }
    
    func deleteStockFromPortfolio(symbol: String?) {
        if symbol == nil {
            return
        }
        var portfolio = getPortfolio()
        let index = getIndexOfStock(symbol: symbol, portfolio: portfolio)
        portfolio.remove(at: index)
        updatePortfolio(portfolio: portfolio)
    }
    
    func deleteStockFromPortfolioByIndex(index: Int) {
        var portfolio = getPortfolio()
        if index < 0 || index >= portfolio.count {
            return
        }
        portfolio.remove(at: index)
        updatePortfolio(portfolio: portfolio)
    }
    
    func getIndexOfStock(symbol: String?, portfolio: [Portfolio]) -> Int {
        for (index, portfolioObj) in portfolio.enumerated() {
            if portfolioObj.symbol == symbol {
                return index
            }
        }
        return -1
    }
    
    func createNewPortfolioObj(symbol: String?, name: String?, currentPrice: Float) -> Portfolio {
        return Portfolio(symbol: symbol ?? "", name: name ?? "", amount: 0, totalCost: 0, currentPrice: currentPrice)
    }
    
    func updatePortfolio(portfolio: [Portfolio]) {
        print(portfolio)
        let portfolioString = try! JSONEncoder().encode(portfolio)
        UserDefaults.standard.set(String(data: portfolioString, encoding: .utf8), forKey: "portfolio")
    }
    
    func getCurrentMoney() -> Float {
        var money = UserDefaults.standard.string(forKey: "currentMoney")
        if money == nil {
            money = "25000.00"
            UserDefaults.standard.set(money, forKey: "currentMoney")
            
        }
        let value =  Float(money!)
        return value ?? 0.00
    }
    
    func getNetWorth() -> Float {
        let portfolio = getPortfolio()
        var netWorth: Float = getCurrentMoney()
        for portfolioObj in portfolio {
            netWorth += Float(portfolioObj.amount) * portfolioObj.currentPrice
        }
        return netWorth
    }
    
    func updateCurrentMoney(currentMoney: Float) {
        UserDefaults.standard.set(String(currentMoney), forKey: "currentMoney");
    }
    
    func clearPortfolio() {
        UserDefaults.standard.removeObject(forKey: "portfolio")
    }
    
    func clearCurrentMoney() {
        UserDefaults.standard.removeObject(forKey: "currentMoney")
    }
}
