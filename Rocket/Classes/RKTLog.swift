//
//  RKTLog.swift
//  Pods-Rocket_Example
//
//  Created by Mitch Treece on 5/8/18.
//

import Foundation

/**
 Helper struct over `Rocket` logging functions.
 */
public struct RKTLog {
    
    /**
     Logs a message with specified parameters.
     
     - Parameter message: The message to log.
     - Parameter level: The log's level; _defaults to debug_.
     - Parameter file: The log's source file; _inferred_.
     - Parameter function: The log's source function; _inferred_.
     - Parameter line: The log's source line number; _inferred_.
     - Parameter rocket: The `Rocket` instance to use for logging; _defaults to shared_.
     */
    @discardableResult
    public init(_ message: String,
                level: Rocket.LogLevel = .debug,
                file: String = #file,
                function: String = #function,
                line: Int = #line,
                rocket: Rocket = Rocket.shared) {
        
        rocket.log(message: message, prefix: nil, level: level, file: file, function: function, line: line)
        
    }
    
    /**
     Logs a message with specified a prefix & other parameters.
     
     - Parameter prefix: The log's prefix.
     - Parameter message: The message to log.
     - Parameter level: The log's level; _defaults to debug_.
     - Parameter file: The log's source file; _inferred_.
     - Parameter function: The log's source function; _inferred_.
     - Parameter line: The log's source line number; _inferred_.
     - Parameter rocket: The `Rocket` instance to use for logging; _defaults to shared_.
     */
    @discardableResult
    public init(prefix: String,
                message: String,
                level: Rocket.LogLevel = .debug,
                file: String = #file,
                function: String = #function,
                line: Int = #line,
                rocket: Rocket = Rocket.shared) {
        
        rocket.log(message: message, prefix: prefix, level: level, file: file, function: function, line: line)
        
    }
    
}
