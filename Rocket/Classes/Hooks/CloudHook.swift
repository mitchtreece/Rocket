//
//  CloudHook.swift
//  Rocket
//
//  Created by Mitch Treece on 10/20/17.
//

import Foundation

public class CloudHook: RocketHook {
    
    public typealias Auth = (token: String, headerField: String)
    
    var url: URL
    var auth: Auth?
    var additionalParameters: [String: Any]?
    
    public init(url: URL, auth: Auth? = nil) {
        
        self.url = url
        self.auth = auth
        
    }
    
    public func didAddEntry(_ entry: LogEntry) {
        
        let serializedEntry = serialization(for: entry)
        Rocket.rocketLog(withContext: "CloudHook", message: "\(serializedEntry) --> \(url.absoluteString)")
        
    }
    
    private func serialization(for entry: LogEntry) -> [String: Any] {
        
        var json: [String: Any] = [
            "level": entry.level.rawValue,
            "message": entry.message,
            "file": (entry.file as NSString).lastPathComponent,
            "function": entry.function,
            "line_number": entry.lineNumber,
            "timestamp": entry.rocket?.dateFormatter.string(from: entry.timestamp) ?? "???"
        ]
        
        if let prefix = entry.prefix {
            json["prefix"] = prefix
        }
        
        return json
        
    }
    
}
