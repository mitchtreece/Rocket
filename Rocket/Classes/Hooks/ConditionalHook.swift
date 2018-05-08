//
//  ConditionalHook.swift
//  Rocket
//
//  Created by Mitch Treece on 5/8/18.
//

import Foundation

public class ConditionalHook: RocketHook {
    
    public typealias Handler = (LogEntry)->()
    
    private var handler: Handler
    
    public init(condition: @escaping RocketHook.Condition, handler: @escaping Handler) {
        
        self.handler = handler
        self.conditions = [condition]
        
    }
    
    public func didAddEntry(_ entry: LogEntry) {
        handler(entry)
    }
    
}
