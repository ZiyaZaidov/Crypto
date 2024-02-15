//
//  Statistic.swift
//  Crypto
//
//  Created by Ziya Zaidov on 28.12.2023.
//

import Foundation

struct Statistic: Identifiable {
    
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentage: Double?
 
    init(title: String, value: String, percentage: Double? = nil) {
        self.title = title
        self.value = value
        self.percentage = percentage
    }
    
}
