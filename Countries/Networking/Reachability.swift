//
//  Reachability.swift
//  Countries
//
//  Created by Mandar Wankhede New on 01/03/20.
//  Copyright © 2020 Mandar Wankhede. All rights reserved.
//

import Network

class Reachability {
    static var isConnected = false
    static private let monitor = NWPathMonitor()
    
    deinit {
        Self.stop()
    }

    class func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            Self.isConnected = (path.status == .satisfied)
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }

    class func stop() {
        monitor.cancel()
    }
}
