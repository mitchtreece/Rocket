//
//  RocketHook.swift
//  Rocket
//
//  Created by Mitch Treece on 10/20/17.
//

import Foundation

private struct AssociatedKeys {
    static var ConditionsKey = "RocketHook.conditions"
}

/**
 A `RocketHook` adds additional functionality to events that meet a certain set of conditions.
 */
public protocol RocketHook: class {
    
    /**
     The hook's execution function.
     
     - Parameter event: The event that triggered the hook.
     */
    func hook(_ event: Event)
    
}

extension RocketHook {
    
    /**
     A condition block. Given an event, a return flag is expected indicating whether the hook should be executed.
     */
    public typealias Condition = (Event)->(Bool)
    
    internal var conditions: [Condition] {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ConditionsKey) as? [Condition] ?? []
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ConditionsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /**
     Adds a condition to the hook's condition set.
     
     - Parameter block: The condition block.
     */
    public func condition(_ block: @escaping Condition) {
        
        var _conditions = self.conditions
        _conditions.append(block)
        self.conditions = _conditions
        
    }
    
}
