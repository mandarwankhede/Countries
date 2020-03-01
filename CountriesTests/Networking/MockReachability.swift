//
//  MockReachability.swift
//  CountriesTests
//
//  Created by Mandar Wankhede New on 02/03/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

@testable import Countries

class MockReachability: Reachability {
    static var startMonitoringCalled = false
    
    override class func startMonitoring() {
         startMonitoringCalled = true
    }
}
