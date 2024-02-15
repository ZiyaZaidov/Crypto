//
//  Double.swift
//  Crypto
//
//  Created by Ziya Zaidov on 25.12.2023.
//

import Foundation

extension Double {
    private var currencyFormated: NumberFormatter {
        let formater = NumberFormatter()
        formater.usesGroupingSeparator = true
        formater.numberStyle = .currency
        formater.currencyCode = "usd"
        formater.currencySymbol = "$"
        formater.minimumFractionDigits = 2
        formater.maximumFractionDigits = 6
        
        return formater
    }
    
    private var currencyFormatedSecondary: NumberFormatter {
        let formater = NumberFormatter()
        formater.usesGroupingSeparator = true
        formater.numberStyle = .currency
        formater.currencyCode = "usd"
        formater.currencySymbol = "$"
        formater.minimumFractionDigits = 2
        formater.maximumFractionDigits = 2
        
        return formater
    }
    
    func asCurrencyWithDecimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormated.string(from: number) ?? "$0.00"
    }
    
    func asCurrencyWithDecimalsSecondary() -> String {
        let number = NSNumber(value: self)
        return currencyFormatedSecondary.string(from: number) ?? "$0.00"
    }
    
    func asNumberToString() -> String {
        return String(format: "%.2f", self)
    }
    
    func asPercentToString() -> String {
        return asNumberToString() + "%"
    }
}
