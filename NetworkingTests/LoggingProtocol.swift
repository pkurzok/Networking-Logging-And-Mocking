//
//  LoggingProtocol.swift
//  Networking
//
//  Created by Peter Kurzok on 14.01.21.
//

import Foundation

class LoggingProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        print("URL:\t\(request.url?.absoluteString ?? "")")
        print("Method:\t\(request.httpMethod ?? "")")
        print("Headers:")
        request.allHTTPHeaderFields?.forEach { key, value in
            print("\t\(key) : \(value)")
        }
        
        if let bodyData = request.httpBody,
           let bodyString = String(data: bodyData, encoding: .utf8)
        {
            print("Body:\t\(bodyString)")
        }
                
        //
        //
        //
        
//        print("Debug Description")
//        print(request.debugDescription)
    
        // By returning `false`, this URLProtocol will do nothing less than logging.
        return false
    }
}
