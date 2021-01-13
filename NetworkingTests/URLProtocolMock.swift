//
//  URLProtocolMock.swift
//  NetworkingTests
//
//  Created by Peter Kurzok on 13.01.21.
//

import Foundation

class URLProtocolMock: URLProtocol {
    // say we want to handle all types of request
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    // ignore this method; just send back what we were given
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        // …and if we have test data for that URL…
        if let data = MockData().mockData {
            // …load it immediately.
            self.client?.urlProtocol(self, didLoad: data)
        }

        // mark that we've finished
        self.client?.urlProtocolDidFinishLoading(self)
    }

    // this method is required but doesn't need to do anything
    override func stopLoading() {}
}
