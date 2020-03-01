//
//  NetworkManager.swift
//  Countries
//
//  Created by Mandar Wankhede on 29/02/20.
//  Copyright © 2019 Maddy. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case noNetwork
}

class NetworkManager {
    private var reachability: Reachability.Type

    init(reachability: Reachability.Type = Reachability.self ) {
        self.reachability = reachability
    }
    
    func performNetworkTask<T: Codable>(endpoint: CountriesAPI,
                                        type: T.Type,
                                        completion: ((_ response: ([T])) -> Void)?) throws {
        guard reachability.isConnected else {
            throw NetworkError.noNetwork
        }
        
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        let urlRequest = URLRequest(url: url)
        
        let urlSession = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            if let _ = error { return }
            guard let data = data else { return }
            
            let response = Response(data: data)
            guard let decoded = response.decode(type) else {
                return
            }
            completion?(decoded)
        }
        urlSession.resume()
    }
    
}
