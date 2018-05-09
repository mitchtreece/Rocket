//
//  ConditionalHook.swift
//  Rocket
//
//  Created by Mitch Treece on 5/8/18.
//

import Foundation

public class ConditionalHook: RocketHook {
    
    public typealias Handler = (Entry)->()
    
    private var handler: Handler
    
    public init(_ condition: @escaping RocketHook.Condition, handler: @escaping Handler) {
        
        self.handler = handler
        self.conditions = [condition]
        
    }
    
    public func hook(_ entry: Entry) {
        handler(entry)
    }
    
}
