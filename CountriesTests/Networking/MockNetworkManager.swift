//
//  MockNetworkManager.swift
//  CountriesTests
//
//  Created by Mandar Wankhede New on 02/03/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

@testable import Countries

class MockNetworkManager: NetworkManager {
    var performNetworkTaskCalled = false
    
    override func performNetworkTask<T: Codable>(endpoint: CountriesAPI,type: T.Type, completion: ((_ response: ([T])) -> Void)?) throws {
        performNetworkTaskCalled = true
    }
}
