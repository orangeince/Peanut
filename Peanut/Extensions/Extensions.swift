//
//  Extensions.swift
//  Peanut
//
//  Created by 少 on 2018/12/14.
//  Copyright © 2018 ShaoZ. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(r: Int, g: Int, b: Int, a: CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }
    
    convenience init(_ value: Int, alpha: CGFloat = 1.0) {
        self.init(r: value, g: value, b: value, a: alpha)
    }
}
