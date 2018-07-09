//
//  ConditionalHook.swift
//  Rocket
//
//  Created by Mitch Treece on 5/8/18.
//

import Foundation

/**
 A hook that executes a handler based on a condition.
 */
public class ConditionalHook: RocketHook {
    
    /**
     The hook's handler block.
     */
    public typealias Handler = (Event)->()
    
    private var handler: Handler
    
    /**
     Initializes a new `ConditionalHook` with a condition & handler.
     
     - Parameter condition: The hook's condition.
     - Parameter handler: The hook's handler.
     */
    public init(_ condition: @escaping RocketHook.Condition, handler: @escaping Handler) {
        
        self.handler = handler
        self.conditions = [condition]
        
    }
    
    public func hook(_ event: Event) {
        handler(event)
    }
    
}
