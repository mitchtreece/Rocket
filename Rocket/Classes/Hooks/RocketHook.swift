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

public protocol RocketHook: class {
    func hook(_ entry: Entry)
}

extension RocketHook {
    
    public typealias Condition = (Entry)->(Bool)
    
    internal var conditions: [Condition] {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ConditionsKey) as? [Condition] ?? []
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ConditionsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func condition(_ block: @escaping Condition) {
        
        var _conditions = self.conditions
        _conditions.append(block)
        self.conditions = _conditions
        
    }
    
}
