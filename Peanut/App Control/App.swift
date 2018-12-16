//
//  App.swift
//  Peanut
//
//  Created by 少 on 2018/12/9.
//  Copyright © 2018 ShaoZ. All rights reserved.
//

import Foundation
import UIKit

final class App {
    var tabBarController: UITabBarController!
    var wordNavigation: UINavigationController!

    init(window: UIWindow) {
        let wordsVC = CardViewController(wordStore: WordStore.shared, didSelectedWord: showInterpretation)
        wordNavigation = UINavigationController(rootViewController: wordsVC)
        wordNavigation.tabBarItem = UITabBarItem(title: "word", image: nil, selectedImage: nil)
        
        let settings = SettingsViewController()
        let settingsNav = UINavigationController(rootViewController: settings)
        settingsNav.tabBarItem = UITabBarItem(title: "Settings", image: nil, selectedImage: nil)
        
        tabBarController = UITabBarController()
        tabBarController.setViewControllers([wordNavigation, settingsNav], animated: false)
        window.rootViewController = tabBarController
        
        setupApparence()
        //wordsVC.didSelectedItem = showInterpretation
    }
    
    func showInterpretation(word: Word) {
        let vc = UIReferenceLibraryViewController(term: word.content)
        vc.title = word.content
        //navigationController.pushViewController(vc, animated: true)
        tabBarController.present(vc, animated: true, completion: nil)
    }
    func setupApparence() {
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().isTranslucent = false
        UIToolbar.appearance().setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        UIToolbar.appearance().setShadowImage(UIImage(), forToolbarPosition: .any)
        UIToolbar.appearance().isTranslucent = false
        setupTheme()
    }
    
    func setupTheme() {
        UITabBar.appearance().tintColor = .black
        UINavigationBar.appearance().tintColor = .black
        UIToolbar.appearance().tintColor = .black
//        UINavigationBar.appearance().barTintColor = UIColor.init(40)
//        UINavigationBar.appearance().titleTextAttributes = [
//            NSAttributedString.Key.foregroundColor: UIColor.white
//        ]
//        UITabBar.appearance().barTintColor = UIColor(40)
    }
}
