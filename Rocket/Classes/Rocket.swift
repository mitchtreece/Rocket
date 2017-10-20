//
//  Rocket.swift
//  Rocket
//
//  Created by Mitch Treece on 8/7/17.
//  Copyright © 2017 Mitch Treece. All rights reserved.
//

import Foundation

public struct RKTLog {
    
    @discardableResult
    public init(_ message: String,
                level: Rocket.LogLevel = .debug,
                file: String = #file,
                function: String = #function,
                line: Int = #line,
                rocket: Rocket = Rocket.shared) {
        
        Rocket.log(rocket: rocket, message: message, prefix: nil, level: level, file: file, function: function, line: line)
        
    }
    
    @discardableResult
    public init(prefix: String,
                message: String,
                level: Rocket.LogLevel = .debug,
                file: String = #file,
                function: String = #function,
                line: Int = #line,
                rocket: Rocket = Rocket.shared) {
        
        Rocket.log(rocket: rocket, message: message, prefix: prefix, level: level, file: file, function: function, line: line)
        
    }
    
}

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
    public var level: LogLevel = .verbose
    
    /// Specifies the level to lock the logger to.
    /// If this is greater than `none`, only logs **equal** to this level will be printed.
    /// - note: If this is greater than `none`, the `maxLevel` property will be ignored.
    public var lockedLevel: LogLevel = .none
    
    /// Specifies the components to be included when logging
    public var components: [Components] = [.prefix, .level, .timestamp, .function, .lineNumber]
    
    /// The date formatter to use when logging
    public var dateFormatter = DateFormatter()
    
    /// The hooks to be called when logging
    public var hooks = [RocketHook]()
    
    internal var entries = [LogEntry]()
    
    private override init() {
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        
    }
    
    public convenience init(level: LogLevel = .debug) {
        
        self.init()
        self.level = level
        
    }
    
    public static func log(rocket: Rocket = Rocket.shared,
                           message: String,
                           prefix: String? = nil,
                           level: LogLevel = .debug,
                           file: String,
                           function: String,
                           line: Int) {
        
        let entry = LogEntry(rocket: rocket,
                             level: level,
                             prefix: prefix,
                             message: message,
                             file: file,
                             function: function,
                             lineNumber: line,
                             timestamp: Date())
        
        // Always execute hooks no matter what the entry's log level is.
        // We should let the hook decide what to do with it.
        
        rocket.executeHooks(for: entry)
        
        guard level != .none else { return }
        
        if level == rocket.lockedLevel || level <= rocket.level {
            
            rocket.entries.append(entry)
            print(entry.logString ?? rocketLog(withContext: nil, message: "Unable to generate log string"))
            
        }
        
    }
    
    // MARK: Hooks
    
    private func executeHooks(for entry: LogEntry) {
        
        for hook in hooks {
            hook.didAddEntry(entry)
        }
        
    }
    
    // MARK: Helpers
    
    internal static func prefix(for level: LogLevel) -> String {
        
        switch level {
        case .verbose: return "💬"
        case .debug: return "⚙️"
        case .error: return "🚫"
        case .warning: return "⚠️"
        case .info: return "❕"
        default: return ""
        }
        
    }
    
    internal static func identifier(for level: LogLevel) -> String {
        
        switch level {
        case .verbose: return "Verbose"
        case .debug: return "Debug"
        case .error: return "Error"
        case .warning: return "Warning"
        case .info: return "Info"
        default: return ""
        }
        
    }
    
    internal static func rocketLog(withContext context: String?, message: String) {
        
        var _context = "[Rocket"
        if let ctx = context {
            _context += " (\(ctx))"
        }
        _context += "]"
        
        print("(🚀) \(_context): \(message)")
        
    }
    
}
