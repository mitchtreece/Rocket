//
//  Rocket.swift
//  Rocket
//
//  Created by Mitch Treece on 8/7/17.
//  Copyright © 2017 Mitch Treece. All rights reserved.
//

import Foundation

@objc public class Rocket: NSObject {
    
    @objc public enum LogLevel: Int, Comparable {
        
        case verbose = 5
        case debug = 4
        case error = 3
        case warning = 2
        case info = 1
        case none = 0
        
        public static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
        
        public static func == (lhs: LogLevel, rhs: LogLevel) -> Bool {
            return lhs.rawValue == rhs.rawValue
        }
        
    }
    
    public enum Components: Int {
        
        case prefix = 1
        case level = 2
        case timestamp = 3
        case function = 4
        case lineNumber = 5
        
    }
    
    /// The shared `Rocket` instance
    public static let shared = Rocket()
    
    /// Specifies the **maximum** log level to print.
    /// Any logs _equal to_ or _less than_ this level will be printed.
    public var maxLevel: LogLevel = .verbose
    
    /// Specifies the level to lock the logger to.
    /// If this is greater than `none`, only logs **equal** to this level will be printed.
    /// - note: If this is greater than `none`, the `maxLevel` property will be ignored.
    public var lockedLevel: LogLevel = .none
    
    /// Specifies the components to be included when logging
    public var components: [Components] = [.prefix, .level, .timestamp, .function, .lineNumber]
    
    /// The date formatter to use when logging
    public var dateFormatter = DateFormatter()
    
    private override init() {
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        
    }
    
    public static func log(_ message: Any, prefix: String? = nil, level: LogLevel = .debug, file: String, function: String, line: Int) {
        
        guard level != .none else { return }
        guard let msg = message as? String else { return }
        
        let timestamp = Rocket.shared.dateFormatter.string(from: Date())
        let symbol = (prefix != nil) ? prefix! : self.symbol(for: level)
        let identifier = self.identifier(for: level)
        
        var functionName = function.replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "+", with: "")
        
        if !functionName.contains(" ") {
            
            // Probably a Swift function. Append filename.
            
            let fileName = (file as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
            functionName = "\(fileName).\(functionName)"
            
        }
        
        if Rocket.shared.lockedLevel > .none && level == Rocket.shared.lockedLevel {
            
            let string = logString(forSymbol: symbol,
                                   identifier: identifier,
                                   timestamp: timestamp,
                                   function: functionName,
                                   line: line,
                                   message: msg)
            
            print(string)
            
        }
        else {
            
            guard level <= Rocket.shared.maxLevel else { return }
            
            let string = logString(forSymbol: symbol,
                                   identifier: identifier,
                                   timestamp: timestamp,
                                   function: functionName,
                                   line: line,
                                   message: msg)
            
            print(string)
            
        }
        
    }
    
    private static func logString(forSymbol symbol: String, identifier: String, timestamp: String, function: String, line: Int, message: String) -> String {
        
        let components = Rocket.shared.components
        
        var string = ""
        
        if components.contains(.prefix) {
            string += "(\(symbol))"
        }
        
        if components.contains(.level) {
            string += " [\(identifier)]"
        }
        
        if components.contains(.timestamp) {
            string += " \(timestamp)"
        }
        
        if components.contains(.function) {
            string += " \(function)"
        }
        
        if components.contains(.lineNumber) {
            string += " (\(line))"
        }
        
        string += (string.count > 0) ? ": \(message)" : message
        
        // Remove beginning characters if needed
        
        let index = string.index(string.startIndex, offsetBy: 1)
        let substring = string.substring(to: index)
        
        if substring == " " {
            string.remove(at: string.startIndex)
        }
        
        return string
        
    }
    
    private static func symbol(for level: LogLevel) -> String {
        
        switch level {
        case .verbose: return "💬"
        case .debug: return "⚙️"
        case .error: return "🚫"
        case .warning: return "⚠️"
        case .info: return "❕"
        default: return ""
        }
        
    }
    
    private static func identifier(for level: LogLevel) -> String {
        
        switch level {
        case .verbose: return "Verbose"
        case .debug: return "Debug"
        case .error: return "Error"
        case .warning: return "Warning"
        case .info: return "Info"
        default: return ""
        }
        
    }
    
}

public struct RKTLog {
    
    @discardableResult
    public init(_ message: String,
                    level: Rocket.LogLevel = .debug,
                     file: String = #file,
                 function: String = #function,
                     line: Int = #line) {
        
        Rocket.log(message, prefix: nil, level: level, file: file, function: function, line: line)
        
    }
    
    @discardableResult
    public init(prefix: String,
               message: String,
                 level: Rocket.LogLevel = .debug,
                  file: String = #file,
              function: String = #function,
                  line: Int = #line) {
        
        Rocket.log(message, prefix: prefix, level: level, file: file, function: function, line: line)
        
    }
    
}
