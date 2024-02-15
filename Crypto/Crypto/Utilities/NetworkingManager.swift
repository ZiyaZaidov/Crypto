//
//  NetworkingManager.swift
//  Crypto
//
//  Created by Ziya Zaidov on 26.12.2023.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkError: LocalizedError {
        case badUrlResponse
        case unknow
        
        var errorDescription: String? {
            switch self {
                
            case .badUrlResponse:
               return  "DEBUG: URL bad respose"
            case .unknow:
                return  "DEBUG: unknow error"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, any Error> {
         return URLSession.shared.dataTaskPublisher(for: url)
              .subscribe(on: DispatchQueue.global(qos: .default))
              .tryMap({ try handleResponse(output: $0)})
              .receive(on: DispatchQueue.main)
              .eraseToAnyPublisher()
    }
    
    static func completionHandler(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    static func handleResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 300 else {throw URLError(.badServerResponse)}
        return output.data
    }
}
