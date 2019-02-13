//
//  UIAlertController+.swift
//  Peanut
//
//  Created by 少 on 2019/2/13.
//  Copyright © 2019 ShaoZ. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func show(message: String? = nil, title: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIViewController.topMost?.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    static var topMost: UIViewController? {
        var top = UIApplication.shared.keyWindow?.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}
