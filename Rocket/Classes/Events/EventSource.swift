//
//  EventSource.swift
//  Rocket
//
//  Created by Mitch Treece on 5/21/18.
//

import Foundation

/**
 Wrapper object over an event's source properties.
 */
public struct EventSource {
    
    /**
     The event's source file.
     */
    public private(set) var file: String
    
    /**
     The event's source function.
     */
    public private(set) var function: String
    
    /**
     The event's source line number.
     */
    public private(set) var line: Int
    
    /**
     The event's formatted function name. This makes the raw function name prettier for logging.
     */
    public var formattedFunctionName: String {
        
        var name = function.replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "+", with: "")
        
        if !name.contains(" ") {
            
            // Probably a Swift function.
            // Prepend filename.
            
            let _file = (file as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
            name = "\(_file).\(name)"
            
        }
        
        return name
        
    }
    
    internal var dictionary: [String: Any] {
        
        return [
            "file": (file as NSString).lastPathComponent,
            "function": function,
            "line_number": line
        ]
        
    }
    
}
