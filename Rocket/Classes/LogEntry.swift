//
//  LogEntry.swift
//  Pods-Rocket_Example
//
//  Created by Mitch Treece on 10/19/17.
//

import Foundation

public struct LogEntry {
    
    internal weak var rocket: Rocket?
    
    var level: Rocket.LogLevel
    var prefix: String?
    var message: String
    var file: String
    var function: String
    var lineNumber: Int
    var timestamp: Date
    
    var logString: String? {
        
        guard let rkt = rocket else { return nil }
        
        let ts = rkt.dateFormatter.string(from: timestamp)
        let pre = (prefix != nil) ? prefix! : Rocket.prefix(for: level)
        let id = Rocket.identifier(for: level)
        
        var functionName = function.replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "+", with: "")
        
        if !functionName.contains(" ") {
            
            // Probably a Swift function. Append filename.
            
            let fileName = (file as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
            functionName = "\(fileName).\(functionName)"
            
        }
        
        let components = rkt.components
        
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
            string += " \(functionName)"
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
    
    var consoleString: String? {
        
        guard let _ = rocket else { return nil }
        
        let pre = (prefix != nil) ? prefix! : Rocket.prefix(for: level)
        let id = Rocket.identifier(for: level)
        
        return "(\(pre)) [\(id)]: \(message)"
        
    }
    
}

extension LogEntry: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        return "LogEntry<\(message)>"
    }
    
    public var debugDescription: String {
        return description
    }
    
}
