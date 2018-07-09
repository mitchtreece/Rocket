//
//  DiskHook.swift
//  Rocket
//
//  Created by Mitch Treece on 10/20/17.
//

import Foundation

/**
 A hook that logs events to disk.
 
 Logs are stored in: _documents/\<date\>.rkt_
 */
public class DiskHook: RocketHook {
        
    private var dateFormatter: DateFormatter!
    
    private var filePath: String? {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard let docsPath = paths.first else { return nil }
        
        let date = dateFormatter.string(from: Date())
        let filename = "\(date).rkt"
        let path = (docsPath as NSString).appendingPathComponent(filename)
        
        return path
        
    }
    
    /**
     Initializes a new `DiskHook` instance.
     */
    public init() {
        
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
    }
    
    public func hook(_ event: Event) {
        
        guard let logEvent = event as? LogEvent else { return }
        
        guard let path = filePath else {
            Rocket._log(context: "DiskHook", message: "Error generating log path", prefix: "💾")
            return
        }
        
        var contents = ""
        
        if FileManager.default.fileExists(atPath: path) {
            contents = (try? String(contentsOfFile: path, encoding: String.Encoding.utf8)) ?? ""
        }
        
        do {
            try "\(contents)\(logEvent.logString ?? "")\n".write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
        }
        catch let error {
            Rocket._log(context: "DiskHook", message: error.localizedDescription, prefix: "💾")
        }
        
    }
    
}
