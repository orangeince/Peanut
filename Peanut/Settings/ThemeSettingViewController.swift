//
//  ThemeSettingViewController.swift
//  Peanut
//
//  Created by 少 on 2018/12/16.
//  Copyright © 2018 ShaoZ. All rights reserved.
//

import UIKit
import Gestalt

class ThemeSettingViewController: ItemsViewController<ThemeItemCell, AppTheme> {
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
                cell.isSelected = true
            } else {
                cell.isSelected = false
            }
        }
        didSelectedItem = { theme in
            guard let current = ThemeManager.default.theme as? AppTheme,
                current != theme else { return }
            ThemeManager.default.theme = theme
        }
        tableView.rowHeight = 56
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectedItem?(items[indexPath.row])
        tableView.reloadData()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ThemeItemCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        observe(theme: \AppTheme.tableCell)
    }
    
    override var isSelected: Bool {
        didSet {
            accessoryType = isSelected ? .checkmark : .none
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
