//
//  Rocket.swift
//  Rocket
//
//  Created by Mitch Treece on 8/7/17.
//  Copyright © 2017 Mitch Treece. All rights reserved.
//

import Foundation

@objcMembers
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
        
        internal var prefix: String {
            
            switch self {
            case .verbose: return "💬"
            case .debug: return "⚙️"
            case .error: return "🚫"
            case .warning: return "⚠️"
            case .info: return "ℹ️"
            default: return ""
            }
            
        }
        
        internal var identifier: String {
            
            switch self {
            case .verbose: return "Verbose"
            case .debug: return "Debug"
            case .error: return "Error"
            case .warning: return "Warning"
            case .info: return "Info"
            default: return ""
            }
            
        }
        
    }
    
    public enum Components: Int {
        
        case prefix = 1
        case level = 2
        case timestamp = 3
        case function = 4
        case lineNumber = 5
        
    }
    
    /// The shared `Rocket` instance.
    public static let shared = Rocket()
    
    /**
     Specifies the **maximum** log level.
     Any logs _equal to_ or _less than_ this level will be printed.
     */
    public var level: LogLevel = .verbose
    
    /**
     Specifies the level to lock the logger to.
     If this is set, only logs **equal** to this level will be printed.
     - Note: If this is set, the `level` property will be ignored.
     */
    public var lockedLevel: LogLevel?
    
    /// Specifies the components to be included when logging.
    public var components: [Components] = [.prefix, .level, .function, .lineNumber]
    
    /// The date formatter to use when logging.
    public var timestampFormatter = DateFormatter()
    
    /// The hooks to be called when logging.
    public var hooks = [RocketHook]()
        
    internal var entries = [Entry]()
    
    private override init() {
        timestampFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    }
    
    /**
     Initializes a new `Rocket` instance with a given `LogLevel`.
     - Parameter level: The log level.
     */
    public convenience init(level: LogLevel = .verbose) {
        
        self.init()
        self.level = level
        
    }
    
    // MARK: Logging
    
    /**
     Logs an event.
     - Parameter message: The log message.
     - Parameter prefix: An optional log prefix.
     - Parameter level: The event's log level.
     - Parameter file: The source filename.
     - Parameter function: The source function name.
     - Parameter line: The source line number.
     */
    public func log(message: String, prefix: String? = nil, level: LogLevel = .debug, file: String, function: String, line: Int) {
        
        func addAndPrintEntry(_ entry: Entry) {
            
            entries.append(entry)
            print(entry.logString ?? Rocket._log(message: "Unable to generate log string"))
            
        }
        
        let entry = Entry(level: level,
                          prefix: prefix,
                          message: message,
                          file: file,
                          function: function,
                          lineNumber: line,
                          timestamp: Date(),
                          rocket: self)
        
        if level == .none {
            
            // Always execute hooks (regardless of what the entry's level is)
            // We should let the hook decide what to do with it
            
            executeHooks(for: entry)
            return
            
        }
        
        if let locked = lockedLevel, level == locked {
            addAndPrintEntry(entry)
        }
        else if level <= self.level {
            addAndPrintEntry(entry)
        }

        executeHooks(for: entry)
        
    }
    
    /**
     Logs an internal (Rocket) event to the console.
     - Parameter source: An optional source string.
     - Parameter message: The log message.
     - Parameter prefix: An optional log prefix.
     */
    public static func _log(source: String? = nil, message: String, prefix: String? = nil) {
        
        let pre = prefix ?? "🚀"
        var _context = "[Rocket"
        
        if let source = source {
            _context += "(\(source))"
        }
        
        _context += "]"
        
        print("(\(pre)) \(_context): \(message)")
        
    }
    
    // MARK: Hooks
    
    private func executeHooks(for entry: Entry) {
        
        hooks.forEach { (hook) in
            
            func check(_ conditions: [RocketHook.Condition]) -> Bool {
                return (conditions.first(where: { !$0(entry) }) == nil)
            }
            
            guard check(hook.conditions) else { return }
            hook.hook(entry)
            
        }
        
    }
    
}
