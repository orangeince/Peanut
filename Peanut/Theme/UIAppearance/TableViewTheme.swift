//
//  TableViewTheme.swift
//  Peanut
//
//  Created by 少 on 2018/12/16.
//  Copyright © 2018 ShaoZ. All rights reserved.
//

import UIKit
import Gestalt

public struct TableViewTheme: Theme {
    let separatorColor: UIColor
    let backgroundColor: UIColor

    init(palette: Palette) {
        separatorColor = palette.colors.dynamic.weakBackground
        backgroundColor = palette.colors.dynamic.weakBackground
    }
}

extension UITableView: Themeable {
    public typealias Theme = TableViewTheme
    
    public func apply(theme: Theme) {
        separatorColor = theme.separatorColor
        backgroundColor = theme.backgroundColor
    }
}

public struct CollectionViewTheme: Theme {
    let backgroundColor: UIColor
    
    init(palette: Palette) {
        backgroundColor = palette.colors.dynamic.weakBackground
    }
}

extension UICollectionView: Themeable {
    public typealias Theme = CollectionViewTheme
    
    public func apply(theme: Theme) {
        backgroundColor = theme.backgroundColor
    }
}
