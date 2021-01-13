//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by Peter Kurzok on 13.01.21.
//

@testable import Networking
import XCTest

class NetworkingTests: XCTestCase {
    func testExample() throws {
        // Set up a configuration to use our mock
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]

        // and create the URLSession from that
        let session = URLSession(configuration: config)

        // Create SampleService and inject the session with the mocked protocol
        let sampleService = SampleService(urlSession: session)
        
        sampleService.getSomething { (results) in
            
            XCTAssertNotNil(results)
            XCTAssertEqual(100, results.count)
            
            XCTAssertEqual(1, results.first?.id)
            XCTAssertEqual(100, results.last?.id)
        }
    }
}
