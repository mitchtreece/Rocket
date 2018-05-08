//
//  RKTLog.swift
//  Pods-Rocket_Example
//
//  Created by Mitch Treece on 5/8/18.
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
