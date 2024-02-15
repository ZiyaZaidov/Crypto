//
//  CoinImageService.swift
//  Crypto
//
//  Created by Ziya Zaidov on 26.12.2023.
//

import Foundation
import SwiftUI
import Combine


class CoinImageService {
    
    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    private let coin: Coin
    private let fileManager = LoacalFileManager.instance
    private let foldername = "coin_images"
    private let imageName: String
    
    
    init(coin: Coin) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: foldername) {
            image = savedImage
            print("DEBUG: retrived image from FILE MANAGER")
        } else {
            downloadCoinImage()
            print("DEBUG: downloadig image now")
        }
    }
    
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else {return}
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.completionHandler(completion:), receiveValue: { [weak self] returnedImage in
                guard let self = self ,let  downloadedImage = returnedImage else {return}
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, folderName: self.foldername, imageName: self.imageName)
            }) 
    }
}
