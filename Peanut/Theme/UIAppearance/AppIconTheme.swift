//
//  AppIconTheme.swift
//  Peanut
//
//  Created by 少 on 2018/12/16.
//  Copyright © 2018 ShaoZ. All rights reserved.
//

import Foundation
import Gestalt

public struct AppIconTheme: Theme {
    let iconName: String

    init(palette: Palette) {
        iconName = palette.assets.appIcon.iconName
    }
}

extension UIApplication: Themeable {
    public typealias Theme = AppIconTheme
    
    public func apply(theme: Theme) {
        setAlternateIconName(theme.iconName) { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("change icon succeed!")
            }
        }
    }
}
