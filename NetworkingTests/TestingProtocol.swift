//
//  TestingProtocol.swift
//  NetworkingTests
//
//  Created by Peter Kurzok on 18.01.21.
//

import Foundation
import XCTest

class TestingProtocol: URLProtocol {
    
    override class func canInit(with request: URLRequest) -> Bool {
     
        guard let title = request.allHTTPHeaderFields?[kWhispersServiceHeader]
        else { XCTFail("WhispersHeader missing"); return false }
        
        let persistedRq = PersistenceHelper().requestWith(title: title)
        let currentRq = request.whispersRequest
        
        XCTAssertEqual(persistedRq.body, currentRq.body)
        
        // TODO: Something wrong here
        if let headers = persistedRq.headers {
            for(key, value) in headers {
                XCTAssertEqual(value, currentRq.headers?[key])
            }
        }
        
        
        
        // That doesnt work
//        XCTAssertEqual(persistedRq.headers, currentRq.headers)
        XCTAssertEqual(persistedRq.method, currentRq.method)
        XCTAssertEqual(persistedRq.url, currentRq.url)
                
        // By returning `false`, this URLProtocol will do nothing less than testing.
        return false
    }
}
