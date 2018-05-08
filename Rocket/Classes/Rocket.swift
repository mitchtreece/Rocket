//
//  Rocket.swift
//  Rocket
//
//  Created by Mitch Treece on 8/7/17.
//  Copyright © 2017 Mitch Treece. All rights reserved.
//

import Foundation

public protocol RocketObserver: class {
    func rocket(_ rocket: Rocket, didLogEntry entry: LogEntry)
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
    /// - Note: If this is greater than `none`, the `level` property will be ignored.
    public var lockedLevel: LogLevel = .none
    
    /// Specifies the components to be included when logging
    public var components: [Components] = [.prefix, .level, .function, .lineNumber]
    
    /// The date formatter to use when logging
    public var timestampFormatter = DateFormatter()
    
    /// The hooks to be called when logging
    public var hooks = [RocketHook]()
        
    internal var entries = [LogEntry]()
    
    private override init() {
        timestampFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
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
        
        if level == .none {
            
            // Always execute hooks (regardless of what the entry's level is)
            // We should let the hook decide what to do with it
            
            rocket.executeHooks(for: entry)
            return
            
        }
        
        if level == rocket.lockedLevel || level <= rocket.level {
            
            rocket.entries.append(entry)
            print(entry.logString ?? internalLog(withContext: nil, message: "Unable to generate log string"))
            
        }
        
        rocket.executeHooks(for: entry)
        
    }
    
    // MARK: Hooks
    
    private func executeHooks(for entry: LogEntry) {
        
        hooks.forEach { (hook) in
            
            func check(_ conditions: [RocketHook.Condition]) -> Bool {
                return (conditions.first(where: { !$0(entry) }) == nil)
            }
            
            guard check(hook.conditions) else { return }
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
        case .info: return "ℹ️"
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
    
    public static func internalLog(withContext context: String?, message: String, prefix: String? = nil) {
        
        let pre = prefix ?? "🚀"
        var _context = "[Rocket"
        
        if let ctx = context {
            _context += "(\(ctx))"
        }
        
        _context += "]"
        
        print("(\(pre)) \(_context): \(message)")
        
    }
    
}
