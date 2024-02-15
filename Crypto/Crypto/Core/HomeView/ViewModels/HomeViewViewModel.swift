//
//  HomeViewViewModel.swift
//  Crypto
//
//  Created by Ziya Zaidov on 25.12.2023.
//

import Foundation
import Combine

class HomeViewViewModel: ObservableObject {
    
    @Published var allCoins = [Coin]()
    @Published var portfolioCoins = [Coin]()
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var searchtextField: String = ""
    
    @Published var statistics: [Statistic] = [
        .init(title: "Title", value: "Value",percentage: 12),
        .init(title: "Title", value: "Value"),
        .init(title: "Title", value: "Value"),
        .init(title: "Title", value: "Value",percentage: -4)
    ]
    
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
//        dataService.$allCoins
//            .sink {[weak self] returnedCoins in
//                self?.allCoins = returnedCoins
//            }
//            .store(in: &cancellables)
        
        $searchtextField
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { (text,startingCoins) -> [Coin]  in
                guard !text.isEmpty else { return startingCoins}
                
                let lowercasedText = text.lowercased()
                
                let filteredCoins = startingCoins.filter { coin  -> Bool in
                    return coin.name.lowercased().contains(lowercasedText) ||
                    coin.id.lowercased().contains(lowercasedText) ||
                    coin.symbol.lowercased().contains(lowercasedText)
                }
                return filteredCoins
            }
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}
