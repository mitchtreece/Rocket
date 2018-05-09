//
//  Entry.swift
//  Pods-Rocket_Example
//
//  Created by Mitch Treece on 10/19/17.
//

import Foundation

public struct Entry {
    
    public internal(set) var level: Rocket.LogLevel
    public internal(set) var prefix: String?
    public internal(set) var message: String
    public internal(set) var file: String
    public internal(set) var function: String
    public internal(set) var lineNumber: Int
    public internal(set) var timestamp: Date
    
    internal weak var rocket: Rocket?
    
    public var formattedFunctionName: String {
        
        var name = function.replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "+", with: "")
        
        if !name.contains(" ") {
            
            // Probably a Swift function.
            // Append filename.
            
            let _file = (file as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
            name = "\(_file).\(name)"
            
        }
        
        return name
        
    }
    
    internal var logString: String? {
        
        guard let rocket = rocket else { return nil }
        
        let ts = rocket.timestampFormatter.string(from: timestamp)
        let pre = (prefix != nil) ? prefix! : level.prefix
        let id = level.identifier
        
        let components = rocket.components
        var string = ""
        
        if components.contains(.prefix) {
            string += "(\(pre))"
        }
        
        if components.contains(.level) {
            string += " [\(id)]"
        }
        
        if components.contains(.timestamp) {
            string += " \(ts)"
        }
        
        if components.contains(.function) {
            string += " \(formattedFunctionName)"
        }
        
        if components.contains(.lineNumber) {
            string += " (\(lineNumber))"
        }
        
        string += (string.count > 0) ? ": \(message)" : message
        
        // Remove beginning characters if needed
        
        let index = string.index(string.startIndex, offsetBy: 1)
        let substring = string[..<index]
        
        if substring == " " {
            string.remove(at: string.startIndex)
        }
        
        return string
        
    }
    
    internal var consoleString: String? {
        
        guard let _ = rocket else { return nil }
        
        let pre = (prefix != nil) ? prefix! : level.prefix
        let id = level.identifier
        
        return "(\(pre)) [\(id)]: \(message)"
        
    }
    
    var dictionary: [String: Any] {
        
        var dict: [String: Any] = [
            "level": level.rawValue,
            "message": message,
            "file": (file as NSString).lastPathComponent,
            "function": function,
            "line_number": lineNumber
        ]
        
        if let ts = rocket?.timestampFormatter.string(from: timestamp) {
            dict["timestamp"] = ts
        }
        
        if let prefix = prefix {
            dict["prefix"] = prefix
        }
        
        return dict
        
    }
    
}

extension Entry: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        return "Entry<\"\(message)\">"
    }
    
    public var debugDescription: String {
        return description
    }
    
}
