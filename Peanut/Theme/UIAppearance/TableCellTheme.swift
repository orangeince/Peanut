//
//  TableCellTheme.swift
//  Peanut
//
//  Created by 少 on 2018/12/26.
//  Copyright © 2018 ShaoZ. All rights reserved.
//


import UIKit
import Gestalt

public struct TableCellTheme: Theme {
    let backgroundColor: UIColor
    let titleTextColor: UIColor
    
    init(palette: Palette) {
        backgroundColor = palette.colors.dynamic.background
        titleTextColor = palette.colors.dynamic.primary
    }
}

extension UITableViewCell: Themeable {
    public typealias Theme = TableCellTheme
    
    public func apply(theme: Theme) {
        backgroundColor = theme.backgroundColor
        contentView.backgroundColor = theme.backgroundColor
        textLabel?.textColor = theme.titleTextColor
    }
}
