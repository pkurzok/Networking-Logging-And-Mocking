//
//  SampleService.swift
//  Networking
//
//  Created by Peter Kurzok on 13.01.21.
//

import Foundation

protocol SampleServiceProtocol {
    func getSomething(completion: @escaping (_ results: [SampleModel]) -> Void)
}

struct SampleService: SampleServiceProtocol {
    var urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func getSomething(completion: @escaping (_ results: [SampleModel]) -> Void) {
        if let url = URL(string: "https://jsonplaceholder.typicode.com/users") {
            urlSession.dataTask(with: url) { data, _, _ in
                handleResponseData(data: data, completion: completion)
            }.resume()
        }
    }

    private func handleResponseData(data: Data?, completion: @escaping (_ results: [SampleModel]) -> Void) {
        guard let data = data else { completion([SampleModel]()); return }

        if let jsonString = String(data: data, encoding: .utf8) {
            print(jsonString)
        } else {
            print("No data")
        }

        do {
            let modelData = try JSONDecoder().decode([SampleModel].self, from: data)
            completion(modelData)
        } catch {
            print(error.localizedDescription)
            completion([SampleModel]())
        }
    }
}
