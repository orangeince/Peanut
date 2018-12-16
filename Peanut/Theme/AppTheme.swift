//
//  AppTheme.swift
//  Peanut
//
//  Created by 少 on 2018/12/16.
//  Copyright © 2018 ShaoZ. All rights reserved.
//

import Gestalt

struct AppTheme: Theme {
    let navigationBar: NavigationBarTheme
    let tabBar: TabBarTheme
    let toolBar: ToolBarTheme
    let tableView: TableViewTheme
    
    let appIconName: String
    
    static let `default`: AppTheme = .light
    
    static let light: AppTheme = .init(palette: .light)
    static let dark: AppTheme = .init(palette: .dark)

    init(palette: Palette) {
        navigationBar = .init(palette: palette)
        tabBar = .init(palette: palette)
        toolBar = .init(palette: palette)
        tableView = .init(palette: palette)
        appIconName = palette.assets.appIcon.iconName
    }
}

extension UIApplication {
    typealias Theme = AppTheme
    
    func apply(theme: Theme) {
        setAlternateIconName(theme.appIconName) { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("change icon succeed!")
            }
        }
    }
}
