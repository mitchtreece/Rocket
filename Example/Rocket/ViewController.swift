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
        
        let rkt = Rocket()
        rkt.components = []
        
        RKTLog(message: "Hello, world!")
        RKTLog(rkt, message: "Hello, world!")
                
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

