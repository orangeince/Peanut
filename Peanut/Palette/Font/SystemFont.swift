//
//  SystemFont.swift
//  Peanut
//
//  Created by 少 on 2018/12/16.
//  Copyright © 2018 ShaoZ. All rights reserved.
//

import UIKit

enum SystemFont {
    typealias Weight = UIFont.Weight
    
    static func with(textStyle: UIFont.TextStyle) -> UIFont {
        return UIFont.preferredFont(forTextStyle: textStyle)
    }
    
    static func with(size: CGFloat, weight: Weight = .regular) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
}

