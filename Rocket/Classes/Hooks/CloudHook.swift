//
//  CloudHook.swift
//  Rocket
//
//  Created by Mitch Treece on 10/20/17.
//

import Foundation

public class CloudHook: RocketHook {
    
    public typealias Authorization = (token: String, headerField: String)
    
    var url: URL
    var authorization: Authorization?
    var additionalParameters: [String: Any]?
    
    public init(url: URL, authorization: Authorization? = nil) {
        
        self.url = url
        self.authorization = authorization
        
    }
    
    public func hook(_ entry: Entry) {
        
        var payload: [String: Any] = [
            "entry": entry.dictionary
        ]
        
        for (key, value) in additionalParameters ?? [:] {
            payload[key] = value
        }
        
        Rocket._log(source: "CloudHook", message: "Sending \(payload)", prefix: "☁️")
        
//        var req = URLRequest(url: url)
//        req.httpBody = try? JSONSerialization.data(withJSONObject: payload, options: [])
//
//        if let auth = authorization {
//            req.addValue(auth.token, forHTTPHeaderField: auth.headerField)
//        }
//
//        URLSession.shared.dataTask(with: req) { (data, res, err) in
//            // Do something
//        }.resume()
        
    }
    
}
