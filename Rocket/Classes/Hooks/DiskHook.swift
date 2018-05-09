//
//  DiskHook.swift
//  Rocket
//
//  Created by Mitch Treece on 10/20/17.
//

import Foundation

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
    
    public init() {
        
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
    }
    
    public func hook(_ entry: Entry) {
        
        guard let path = filePath else {
            Rocket._log(source: "DiskHook", message: "Error generating log path", prefix: "💾")
            return
        }
        
        var contents = ""
        
        if FileManager.default.fileExists(atPath: path) {
            contents = (try? String(contentsOfFile: path, encoding: String.Encoding.utf8)) ?? ""
        }
        
        do {
            try "\(contents)\(entry.logString ?? "")\n".write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
        }
        catch let error {
            Rocket._log(source: "DiskHook", message: error.localizedDescription, prefix: "💾")
        }
        
    }
    
}
