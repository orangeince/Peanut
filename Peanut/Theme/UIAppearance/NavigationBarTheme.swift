//
//  NavigationBarTheme.swift
//  Peanut
//
//  Created by 少 on 2018/12/16.
//  Copyright © 2018 ShaoZ. All rights reserved.
//

import Foundation
import Gestalt

public struct NavigationBarTheme: Theme {
    let barStyle: UIBarStyle
    let titleFont: UIFont
    let titleColor: UIColor
    let tintColor: UIColor
    let isTranslucent: Bool
    let backgroundImage: UIImage?
    let shadowImage: UIImage?
    
    
    init(palette: Palette) {
        self.barStyle = palette.styles.barStyle
        self.titleFont = palette.fonts.static.navigationBarTitle
        self.titleColor = palette.colors.dynamic.primary
        self.tintColor = palette.colors.dynamic.tint
        self.isTranslucent = palette.styles.barTranslucency
        backgroundImage = palette.styles.barBackground
        shadowImage = palette.styles.barShadowImage
    }
}

extension UINavigationBar: Themeable {
    public typealias Theme = NavigationBarTheme
    
    public func apply(theme: Theme) {
        self.barStyle = theme.barStyle
        self.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: theme.titleColor,
            NSAttributedString.Key.font: theme.titleFont
        ]
        
        self.isTranslucent = theme.isTranslucent
        self.tintColor = theme.tintColor
        self.setBackgroundImage(theme.backgroundImage, for: .default)
        self.shadowImage = theme.shadowImage
    }
}
