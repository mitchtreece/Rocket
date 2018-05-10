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
        
        RKTLog("Hello, world!")
        
        let pressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
        view.addGestureRecognizer(pressRecognizer)
        
    }
    
    @objc private func didLongPress(_ recognizer: UILongPressGestureRecognizer) {
        
        let vc = RocketConsoleViewController.instance()
        present(vc, animated: true, completion: nil)
        
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
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ObjcViewController") {
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true, completion: nil)
        }
        
    }

}
