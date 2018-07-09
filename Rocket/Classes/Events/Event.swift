//
//  Event.swift
//  Pods-Rocket_Example
//
//  Created by Mitch Treece on 5/21/18.
//

import Foundation

/**
 Protocol describing the base properties of an event.
 */
public protocol Event {
    
    /**
     The event's identifier.
     */
    var id: String { get }
    
    /**
     The event's timestamp.
     */
    var timestamp: Date { get set }
    
    /**
     The event's source.
     */
    var source: EventSource { get set }
    
    /**
     The event's dictionary representation.
     */
    var dictionary: [String: Any] { get }
    
}
