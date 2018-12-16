//
//  ThemeSettingViewController.swift
//  Peanut
//
//  Created by 少 on 2018/12/16.
//  Copyright © 2018 ShaoZ. All rights reserved.
//

import UIKit
import Gestalt

class ThemeSettingViewController: ItemsViewController<UITableViewCell, AppTheme> {
    let current = ThemeManager.default.theme
    init() {
        super.init(items: [.light, .dark]) { (cell, theme) in
            if theme == AppTheme.light {
                cell.textLabel?.text = "Light"
            } else {
                cell.textLabel?.text = "Dark"
            }
            if let current = ThemeManager.default.theme as? AppTheme,
                current == theme {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        didSelectedItem = { theme in
            guard let current = ThemeManager.default.theme as? AppTheme,
                current != theme else { return }
            ThemeManager.default.theme = theme
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
