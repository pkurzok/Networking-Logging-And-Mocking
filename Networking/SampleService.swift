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
        
    func getSomething() {
        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts") {
           
            URLSession.shared.dataTask(with: url) { data, response, error in
                 if let data = data {
                    if let jsonString = String(data: data, encoding: .utf8) {
                       print(jsonString)
                    }
                  }
              }.resume()
        }
    }
}
