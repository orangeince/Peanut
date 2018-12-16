//
//  AppTheme.swift
//  Peanut
//
//  Created by 少 on 2018/12/16.
//  Copyright © 2018 ShaoZ. All rights reserved.
//

import Gestalt

struct AppTheme: Theme {
    let id: Int
    let navigationBar: NavigationBarTheme
    let tabBar: TabBarTheme
    let toolBar: ToolBarTheme
    let tableView: TableViewTheme
    let collectionView: CollectionViewTheme
    
    let appIconName: String
    
    static let `default`: AppTheme = .light
    
    static let light: AppTheme = .init(palette: .light, id: 0)
    static let dark: AppTheme = .init(palette: .dark, id: 1)

    init(palette: Palette, id: Int) {
        navigationBar = .init(palette: palette)
        tabBar = .init(palette: palette)
        toolBar = .init(palette: palette)
        tableView = .init(palette: palette)
        appIconName = palette.assets.appIcon.iconName
        collectionView = .init(palette: palette)
        self.id = id
    }
}

extension AppTheme: Equatable {
    static func == (lhs: AppTheme, rhs: AppTheme) -> Bool {
        return lhs.id == rhs.id
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
