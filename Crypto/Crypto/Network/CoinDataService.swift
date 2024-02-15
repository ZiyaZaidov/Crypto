//
//  CoinDataService.swift
//  Crypto
//
//  Created by Ziya Zaidov on 26.12.2023.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [Coin] = []
    
    var coinsSubsription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    private func getCoins() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h&locale=en") else {return}
        
        coinsSubsription = NetworkingManager.download(url: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.completionHandler(completion:), receiveValue: { [weak self] returnCoins in
                self?.allCoins = returnCoins
                self?.coinsSubsription?.cancel()
            })
        
    }
}
