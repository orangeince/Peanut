//
//  AssetPalette.swift
//  Peanut
//
//  Created by 少 on 2018/12/16.
//  Copyright © 2018 ShaoZ. All rights reserved.
//

import UIKit

extension String {
    var image: UIImage? {
        return UIImage(named: self)
    }
}

struct TabbarAssetPalette: PaletteProtocol {
    let wordImage: UIImage?
    let wordSelectedImage: UIImage?
    let settingsImage: UIImage?
    let settingsSelectedImage: UIImage?

    static let light: TabbarAssetPalette = .init(
        wordImage: "tab_word_light".image,
        wordSelectedImage: "tab_word_se_light".image,
        settingsImage: "tab_settings_light".image,
        settingsSelectedImage: "tab_settings_se_light".image
    )
    
    static let dark: TabbarAssetPalette = .init(
        wordImage: "tab_word_black".image,
        wordSelectedImage: "tab_word_se_black".image,
        settingsImage: "tab_settings_black".image,
        settingsSelectedImage: "tab_settings_se_black".image
    )
    
    static var debug: TabbarAssetPalette = .init(
        wordImage: "tab_word_light".image,
        wordSelectedImage: "tab_word_se_light".image,
        settingsImage: "tab_settings_light".image,
        settingsSelectedImage: "tab_settings_se_light".image
    )
}

struct AppIconPalette: PaletteProtocol {
    let iconName: String
    static let light: AppIconPalette = .init(iconName: "lightIcon")
    static let dark: AppIconPalette = .init(iconName: "darkIcon")
    static let debug: AppIconPalette = .init(iconName: "lightIcon")
}

struct AssetPalette: PaletteProtocol {
    let tabbar: TabbarAssetPalette
    let appIcon: AppIconPalette
    
    static let light: AssetPalette = .init(
        tabbar: .light,
        appIcon: .light
    )
    
    static let dark: AssetPalette = .init(
        tabbar: .dark,
        appIcon: .dark
    )
    
    static let debug: AssetPalette = .init(
        tabbar: .debug,
        appIcon: .debug
    )
}

