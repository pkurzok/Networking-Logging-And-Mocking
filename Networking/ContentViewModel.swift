//
//  ContentViewModel.swift
//  Networking
//
//  Created by Peter Kurzok on 13.01.21.
//

import Foundation

struct ContentViewModel {
    
    var service: SampleServiceProtocol
    
    init(service: SampleServiceProtocol = SampleService()) {
        self.service = service
    }
    
    func fetchData() {
        service.getSomething()
    }
}
