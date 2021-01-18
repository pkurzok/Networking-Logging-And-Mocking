//
//  NetworkingExtension.swift
//  Networking
//
//  Created by Peter Kurzok on 18.01.21.
//

import Foundation

extension URLRequest {
    
    internal var whispersRequest: WhispersRequest {
        WhispersRequest(url: url, method: httpMethod, headers: allHTTPHeaderFields, body: httpBody)
    }
}

extension Bundle {
    
    func decode<T: Codable>(_ file: String, withExtension: String) -> T {
        
        guard let url = self.url(forResource: file, withExtension: withExtension) else {
            fatalError("Failed to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}

