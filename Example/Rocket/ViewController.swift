//
//  ViewController.swift
//  Rocket
//
//  Created by mitchtreece on 08/07/2017.
//  Copyright (c) 2017 mitchtreece. All rights reserved.
//

import UIKit
import Rocket

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        RKTLog("This is some information", level: .info)
        RKTLog("This is a warning", level: .warning)
        RKTLog("A wild error appeared!", level: .error)
        RKTLog("This is a debug message", level: .debug)
        RKTLog("This is long verbose text. Woohoo! #yolo bitches! Cowabunga fugger!)", level: .verbose)
        
        let rocket = Rocket()
        let cloud = CloudHook(url: URL(string: "http://path/to/endpoint")!, auth: nil)
        rocket.hooks = [cloud]
        
        RKTLog("Testing hooks", rocket: rocket)
        
        let pressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
        view.addGestureRecognizer(pressRecognizer)
                
    }
    
    @objc private func didLongPress(_ recognizer: UILongPressGestureRecognizer) {
        
        let vc = RocketConsoleViewController.instance()
        present(vc, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapObjcButton(_ sender: UIButton) {
        
        let vc = ObjcViewController()
        present(vc, animated: true, completion: nil)
        
    }

}

