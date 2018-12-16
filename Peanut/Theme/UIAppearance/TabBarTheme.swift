//
//  TabBarTheme.swift
//  Peanut
//
//  Created by 少 on 2018/12/16.
//  Copyright © 2018 ShaoZ. All rights reserved.
//

import Gestalt

public struct TabBarTheme: Theme {
    let barStyle: UIBarStyle
    let tintColor: UIColor
    let isTranslucent: Bool
    let backgroundImage: UIImage?
    let shadowImage: UIImage?
    
    init(palette: Palette) {
        barStyle = palette.styles.barStyle
        tintColor = palette.colors.dynamic.tint
        isTranslucent = palette.styles.barTranslucency
        backgroundImage = palette.styles.barBackground
        shadowImage = palette.styles.barShadowImage
    }
}

extension UITabBar: Themeable {
    public typealias Theme = TabBarTheme
    
    public func apply(theme: Theme) {
        self.barStyle = theme.barStyle
        self.isTranslucent = theme.isTranslucent
        self.tintColor = theme.tintColor
        self.backgroundImage = theme.backgroundImage
        self.shadowImage = theme.shadowImage
    }
}
