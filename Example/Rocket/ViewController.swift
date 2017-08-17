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
        
        RKTLog("Hello, world!")
        RKTLog(prefix: "🐞", message: "You found a bug!")
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

