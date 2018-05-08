//
//  ViewController.swift
//  Rocket
//
//  Created by Mitch Treece on 08/07/2017.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import UIKit
import Rocket

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let pressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
        view.addGestureRecognizer(pressRecognizer)
        
        let cloud = CloudHook(url: URL(string: "http://path/to/endpoint")!, auth: nil)
        cloud.condition({ $0.level == Rocket.LogLevel.error })
        
        let alert = ConditionalHook(condition: { $0.level == Rocket.LogLevel.error }, handler: { (entry) in
            
            let alert = UIAlertController(title: "Error", message: entry.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        })
        
        Rocket.shared.hooks = [cloud, alert]
        RKTLog("Hello, world!")
                
    }
    
    @objc private func didLongPress(_ recognizer: UILongPressGestureRecognizer) {
        
        let vc = RocketConsoleViewController.instance()
        present(vc, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapButton(_ sender: UIButton) {
        
        let level = Rocket.LogLevel(rawValue: sender.tag) ?? .none
        
        switch level {
        case .none: break
        case .info: RKTLog("This is some information", level: .info)
        case .warning: RKTLog("This is a warning", level: .warning)
        case .error: RKTLog("A wild error appeared!", level: .error)
        case .debug: RKTLog("This is a debug message", level: .debug)
        case .verbose: RKTLog("This is an extremely long verbose message. Woohoo!", level: .verbose)
        }
        
    }
    
    @IBAction func didTapObjcButton(_ sender: UIButton) {
        
        let vc = ObjcViewController()
        present(vc, animated: true, completion: nil)
        
    }

}
