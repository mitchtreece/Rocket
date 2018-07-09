//
//  Rocket+Logging.swift
//  Rocket
//
//  Created by Mitch Treece on 5/21/18.
//

import Foundation

public extension Rocket /* Logging */ {
    
    /**
     Logs an event with specified parameters.
     
     - Parameter message: The log message.
     - Parameter prefix: An optional log prefix.
     - Parameter level: The event's log level; _defaults to debug_.
     - Parameter file: The source filename; _inferred_.
     - Parameter function: The source function name; _inferred_.
     - Parameter line: The source line number; _inferred_.
     */
    public func log(message: String, prefix: String? = nil, level: LogLevel = .debug, file: String, function: String, line: Int) {
        
        func addAndPrintEvent(_ event: LogEvent) {
            
            logEvents.append(event)
            print(event.logString ?? Rocket._log(message: "Unable to generate log string"))
            
        }
        
        var event = LogEvent(level: level, prefix: prefix, message: message, file: file, function: function, line: line)
        event.rocket = self
        
        if level == .none {
            
            // Always execute hooks (regardless of what the entry's level is)
            // We should let the hook decide what to do with it
            
            executeHooks(for: event)
            return
            
        }
        
        if let locked = lockedLevel, level == locked {
            addAndPrintEvent(event)
        }
        else if level <= self.level {
            addAndPrintEvent(event)
        }
        
        executeHooks(for: event)
        
    }
    
    /**
     Logs an internal (Rocket) event to the console.
     
     - Parameter context: An optional context (source) string.
     - Parameter message: The log message.
     - Parameter prefix: An optional log prefix.
     */
    public static func _log(context: String? = nil, message: String, prefix: String? = nil) {
        
        let pre = prefix ?? "🚀"
        var _context = "[Rocket"
        
        if let context = context {
            _context += "(\(context))"
        }
        
        _context += "]"
        
        print("(\(pre)) \(_context): \(message)")
        
    }
    
}
