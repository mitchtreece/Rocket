//
//  Rocket+Hooks.swift
//  Rocket
//
//  Created by Mitch Treece on 5/21/18.
//

import Foundation

extension Rocket /* Hooks */ {
    
    internal func executeHooks(for event: Event) {
        
        hooks.forEach { (hook) in
            
            func check(_ conditions: [RocketHook.Condition]) -> Bool {
                return (conditions.first(where: { !$0(event) }) == nil)
            }
            
            guard check(hook.conditions) else { return }
            hook.hook(event)
            
        }
        
    }
    
}
