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

struct WhispersRequest: Codable {
    let url: URL?
    let method: String?
    let headers: [String : String]?
    let body: Data?
    
    func log() {
        print("URL:\t\(url?.absoluteString ?? "")")
        print("Method:\t\(method ?? "")")
        
        if let headers = headers, headers.count > 0 {
            print("Headers:")
            headers.forEach { key, value in
                print("\t\(key) : \(value)")
            }
        } else {
            print("Headers:\tNONE")
        }
        
        if let bodyData = body,
           let bodyString = String(data: bodyData, encoding: .utf8)
        {
            print("Body:\t\(bodyString)")
        } else {
            print("Body:\t- EMPTY -")
        }
    }
}
