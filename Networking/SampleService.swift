//
//  SampleService.swift
//  Networking
//
//  Created by Peter Kurzok on 13.01.21.
//

import Foundation

protocol SampleServiceProtocol {
    func getSomething()
}

struct SampleService: SampleServiceProtocol {
    var urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
        
    func getSomething() {
        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts") {
            urlSession.dataTask(with: url) { data, _, _ in
                if let data = data {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print(jsonString)
                    }
                }
            }.resume()
        }
    }
}
