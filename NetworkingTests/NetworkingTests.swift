//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by Peter Kurzok on 13.01.21.
//

@testable import Networking
import XCTest

class NetworkingTests: XCTestCase {
    func testService() {
        // Set up a configuration to use our mock
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]

        // and create the URLSession from that
        let session = URLSession(configuration: config)

        // Create SampleService and inject the session with the mocked protocol
        let sampleService = SampleService(urlSession: session)
        
        let expectation = self.expectation(description: "AsyncCall")
        
        sampleService.getSomething { results in
            
            XCTAssertNotNil(results)
            XCTAssertEqual(10, results.count)
            
            XCTAssertEqual("Leanne Graham", results.first?.name)
            XCTAssertEqual("Rey.Padberg@karina.biz", results.last?.email)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLogging() {
        let config = URLSessionConfiguration.default
        config.protocolClasses?.insert(LoggingProtocol.self, at: 0)
        let session = URLSession(configuration: config)
        
        let expectation = self.expectation(description: "AsyncCall")
        
        let sampleService = SampleService(urlSession: session)
        sampleService.getSomething { results in
            
            XCTAssertNotNil(results)
            XCTAssertEqual(10, results.count)
            
            XCTAssertEqual("Leanne Graham", results.first?.name)
            XCTAssertEqual("Rey.Padberg@karina.biz", results.last?.email)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
