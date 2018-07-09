//
//  Rocket.swift
//  Rocket
//
//  Created by Mitch Treece on 8/7/17.
//  Copyright © 2017 Mitch Treece. All rights reserved.
//

import Foundation

/**
 `Rocket` is a lightweight logging and event frfamework with built-in level & conditional systems.
 */
@objcMembers
public class Rocket: NSObject {
    
    /**
     Representation of the various log levels.
     */
    @objc public enum LogLevel: Int, Comparable {
        
        /// A verbose log level; _value = 5_.
        case verbose = 5
        
        /// A debug log level; _value = 4_.
        case debug = 4
        
        /// An error log level; _value = 3_.
        case error = 3
        
        /// A warning log level; _value = 2_.
        case warning = 2
        
        /// An info log level; _value = 1_.
        case info = 1
        
        /// A log level representing the absence of a log level, spooky!; _value = 0_.
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
    
    /**
     Representation of the various log components.
     */
    public enum Components: Int {
        
        /// A prefix component.
        case prefix = 1
        
        /// A log level component.
        case level = 2
        
        /// A timestamp component.
        case timestamp = 3
        
        /// A function name component.
        case function = 4
        
        /// A line number component.
        case lineNumber = 5
        
    }
    
    /**
     The shared `Rocket` instance.
     */
    public static let shared = Rocket()
    
    /**
     The **maximum** log level.
     
     Any logs _equal to_ or _less than_ this level will be printed. _defaults to verbose_.
     */
    public var level: LogLevel = .verbose
    
    /**
     Specifies the level to lock the logger to.
     
     If this is set, only logs **equal** to this level will be printed.
     
     **Note**: If this is set, the `level` property will be ignored.
     */
    public var lockedLevel: LogLevel?
    
    /**
     The components to include when logging.
     */
    public var components: [Components] = [.prefix, .level, .function, .lineNumber]
    
    /**
     The date formatter to use when logging.
     */
    public var timestampFormatter = DateFormatter()
    
    /**
     The hooks to use when logging.
     */
    public var hooks = [RocketHook]()
        
    internal var logEvents = [LogEvent]()
    
    private override init() {
        timestampFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    }
    
    /**
     Initializes a new `Rocket` instance with a given log level.
     
     - Parameter level: The log level; _defaults to verbose_.
     */
    public convenience init(level: LogLevel = .verbose) {
        
        self.init()
        self.level = level
        
    }
    
}
