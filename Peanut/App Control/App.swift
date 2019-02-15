//
//  App.swift
//  Peanut
//
//  Created by 少 on 2018/12/9.
//  Copyright © 2018 ShaoZ. All rights reserved.
//

import Foundation
import UIKit
import Gestalt

final class App {
    var tabBarController: UITabBarController!
    var wordNavigation: UINavigationController!
    var disposables: [Gestalt.Disposable]?

    init(window: UIWindow) {
        let cardVC = CardViewController(wordStore: WordStore.shared, didSelectedWord: showInterpretation)
        let allWordsVC = AllWordsViewController(wordStore: WordStore.shared)
        let wordsVC = WordsViewController(cardVC: cardVC, allWordsVC: allWordsVC)
        wordsVC.title = "Words"
        wordNavigation = UINavigationController(rootViewController: wordsVC)
        let wordBar = UITabBarItem(title: nil,
                                   image: UIImage(named: "tab_word_light"),
                                   selectedImage: UIImage(named: "tab_word_se_light"))
        wordBar.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
        wordNavigation.tabBarItem = wordBar
        
        let settings = SettingsViewController()
        settings.title = "Settings"
        let settingsNav = UINavigationController(rootViewController: settings)
        let settingsBar = UITabBarItem(title: nil,
                                       image: UIImage(named: "tab_settings_light"),
                                       selectedImage: UIImage(named: "tab_settings_se_light"))
        settingsBar.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
        settingsNav.tabBarItem = settingsBar

        tabBarController = UITabBarController()
        tabBarController.setViewControllers([wordNavigation, settingsNav], animated: false)
        window.rootViewController = tabBarController
        
        setupTheme()
    }
    
    func showInterpretation(word: Word) {
        let vc = UIReferenceLibraryViewController(term: word.content)
        vc.title = word.content
        tabBarController.present(vc, animated: true, completion: nil)
    }
    
    func setupTheme() {
        typealias Theme = AppTheme
        if UserDefaults.standard.bool(forKey: "appTheme.isDark") {
            ThemeManager.default.theme = Theme.dark
        } else {
            ThemeManager.default.theme = Theme.default
        }

        self.disposables = [
            UINavigationBar.observe(theme: \Theme.navigationBar) { $0.appearance() },
            UITabBar.observe(theme: \Theme.tabBar) { $0.appearance() },
            UITableView.observe(theme: \Theme.tableView) { $0.appearance() },
            UICollectionView.observe(theme: \Theme.collectionView) { $0.appearance() },
            UIToolbar.observe(theme: \Theme.toolBar) { $0.appearance() }
        ]
        UIApplication.shared.observe(theme: \Theme.appIcon)
    }
}
