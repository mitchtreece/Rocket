//
//  LogEvent.swift
//  Rocket
//
//  Created by Mitch Treece on 5/21/18.
//

import Foundation

/**
 A log event.
 */
public struct LogEvent: Event {
    
    // MARK: Event
    
    public var id: String
    public var timestamp: Date
    public var source: EventSource
    public var dictionary: [String : Any] {
        
        var dict: [String: Any] = [
            "id": id,
            "level": level.identifier,
            "message": message,
            "source": source.dictionary
        ]
        
        if let ts = rocket?.timestampFormatter.string(from: timestamp) {
            dict["timestamp"] = ts
        }
        
        if let prefix = prefix {
            dict["prefix"] = prefix
        }
        
        return dict
        
    }
    
    // MARK: Other
    
    /**
     The event's log level.
     */
    public internal(set) var level: Rocket.LogLevel
    
    /**
     The event's log prefix.
     */
    public internal(set) var prefix: String?
    
    /**
     The event's message.
     */
    public internal(set) var message: String
    
    // MARK: Internal
    
    internal weak var rocket: Rocket?
    
    internal init(level: Rocket.LogLevel, prefix: String? = nil, message: String, file: String, function: String, line: Int) {
        
        self.id = UUID().uuidString
        self.timestamp = Date()
        self.source = EventSource(file: file, function: function, line: line)
        self.level = level
        self.prefix = prefix
        self.message = message
        
    }
    
    internal var logString: String? {
        
        guard let rocket = rocket else { return nil }
        
        let ts = rocket.timestampFormatter.string(from: timestamp)
        let pre = (prefix != nil) ? prefix! : level.prefix
        let levelId = level.identifier
        
        let components = rocket.components
        var string = ""
        
        if components.contains(.prefix) {
            string += "(\(pre))"
        }
        
        if components.contains(.level) {
            string += " [\(levelId)]"
        }
        
        if components.contains(.timestamp) {
            string += " \(ts)"
        }
        
        if components.contains(.function) {
            string += " \(source.formattedFunctionName)"
        }
        
        if components.contains(.lineNumber) {
            string += " (\(source.line))"
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
        let levelId = level.identifier
        
        return "(\(pre)) [\(levelId)]: \(message)"
        
    }
    
}

extension LogEvent: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        return "LogEvent<\"\(message)\", level: \(level.identifier.lowercased())>"
    }
    
    public var debugDescription: String {
        return description
    }
    
}
