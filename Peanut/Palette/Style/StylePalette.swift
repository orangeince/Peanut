//
//  StylePalette.swift
//  Peanut
//
//  Created by 少 on 2018/12/16.
//  Copyright © 2018 ShaoZ. All rights reserved.
//

import UIKit

struct StageDesignViewStylePalette: PaletteProtocol {
    let lightOpacity: Float
    let shadowOpacity: Float
    
    static let light: StageDesignViewStylePalette = .init(
        lightOpacity: 0.0,
        shadowOpacity: 0.0
    )
    
    static let dark: StageDesignViewStylePalette = .init(
        lightOpacity: 1.0,
        shadowOpacity: 1.0
    )
    
    static var debug: StageDesignViewStylePalette {
        return StageDesignViewStylePalette.light
    }
}

struct StylePalette: PaletteProtocol {
    let stageDesign: StageDesignViewStylePalette
    
    let barStyle: UIBarStyle
    let barTranslucency: Bool
    let barBackground: UIImage?
    let barShadowImage: UIImage?

    static let light: StylePalette = .init(
        stageDesign: .light,
        barStyle: .default,
        barTranslucency: false,
        barBackground: UIImage(),
        barShadowImage: UIImage()
    )
    
    static let dark: StylePalette = .init(
        stageDesign: .dark,
        barStyle: .black,
        barTranslucency: false,
        barBackground: UIImage(),
        barShadowImage: UIImage()
    )
    
    static var debug: StylePalette {
        return StylePalette.light
    }
}

