//
//  Response.swift
//  Countries
//
//  Created by Mandar Wankhede on 29/02/20.
//  Copyright © 2019 Maddy. All rights reserved.
//

import Foundation

struct Response {
    fileprivate var data: Data
    init(data: Data) {
        self.data = data
    }
}

extension Response {
    public func decode<T: Codable>(_ type: T.Type) -> [T]? {
        let jsonDecoder = JSONDecoder()
        do {
            let response = try jsonDecoder.decode([T].self, from: data)
            return response
        } catch let error {
            print(error)
            return nil
        }
    }
}
