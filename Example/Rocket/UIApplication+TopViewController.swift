//
//  UIResponder+Next.swift
//  Rocket_Example
//
//  Created by Mitch Treece on 5/16/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

extension UIApplication {
    
    static func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
        
    }
    
}
