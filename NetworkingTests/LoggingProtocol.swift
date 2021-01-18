//
//  LoggingProtocol.swift
//  Networking
//
//  Created by Peter Kurzok on 14.01.21.
//

import Foundation

let kWhispersServiceHeader = "WhispersMethod"

class LoggingProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        
        guard let title = request.allHTTPHeaderFields?[kWhispersServiceHeader] else { return false }
        
        let whispersRq = request.whispersRequest
        
        whispersRq.log()
        
        PersistenceHelper().persist(request: whispersRq, title: title)
           
        // By returning `false`, this URLProtocol will do nothing less than logging.
        return false
    }
}

struct PersistenceHelper {
    
    private let encoder = JSONEncoder()
    
    func requestWith(title: String, withExtension: String = "json") -> WhispersRequest {
        let rq: WhispersRequest = Bundle.main.decode(title, withExtension: withExtension)
        return rq
    }
    
    func persist(request: WhispersRequest, title: String, fileManager: FileManager = .default) {
        
        do {
            let fileURL = fileUrl(withName: title, using: fileManager)
            
            print("Will persist to Url: \(fileURL.absoluteString)")
            
            let requestData = try encoder.encode(request)
            try requestData.write(to: fileURL)
        } catch {
            print("Error persisting Request: \(error.localizedDescription)")
        }
    }
    
    private func fileUrl(withName name: String, using fileManager: FileManager) -> URL{
        let folderURLs = fileManager.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )
        return folderURLs[0].appendingPathComponent(name + ".json")
    }
}
