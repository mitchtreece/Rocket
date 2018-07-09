//
//  CloudHook.swift
//  Rocket
//
//  Created by Mitch Treece on 10/20/17.
//

import Foundation

/**
 A hook that sends `JSON` encoded events to a web service.
 */
public class CloudHook: RocketHook {
    
    /**
     An authorization type containing a _token_ & _header field_.
     */
    public typealias Authorization = (token: String, headerField: String)
    
    /**
     The hook's `URL`.
     */
    var url: URL
    
    /**
     The hook's optional authorization.
     */
    var authorization: Authorization?
    
    /**
     Additional properties to add to the `JSON` object before it's sent.
     */
    var additionalParameters: [String: Any]?
    
    /**
     Initializes a new `CloudHook` with a `URL` & authorization.
     */
    public init(url: URL, authorization: Authorization? = nil) {
        
        self.url = url
        self.authorization = authorization
        
    }
    
    public func hook(_ event: Event) {
        
        var payload: [String: Any] = [
            "event": event.dictionary
        ]
        
        for (key, value) in additionalParameters ?? [:] {
            payload[key] = value
        }
        
        Rocket._log(context: "CloudHook", message: "Sending \(payload)", prefix: "☁️")
        
        var req = URLRequest(url: url)
        req.httpBody = try? JSONSerialization.data(withJSONObject: payload, options: [])

        if let auth = authorization {
            req.addValue(auth.token, forHTTPHeaderField: auth.headerField)
        }

        URLSession.shared.dataTask(with: req) { (data, res, err) in
            // Do nothing for now
        }.resume()
        
    }
    
}
