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
        let words = [
            Word(content: "peanut", createdAt: Date())
        ]
//        let wordsVC = ItemsViewController(items: words) { (cell: WordCell, word) in
//            cell.textLabel?.text = word.content
//            cell.detailTextLabel?.text = word.createdAt.formattedString()
//        }
        let wordsVC = CardViewController(words: words, didSelectedWord: showInterpretation)
        wordsVC.title = "Words"
        wordNavigation = UINavigationController(rootViewController: wordsVC)
        wordNavigation.tabBarItem = UITabBarItem(title: "word", image: nil, selectedImage: nil)
        tabBarController = UITabBarController()
        tabBarController.setViewControllers([wordNavigation], animated: false)
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
        UINavigationBar.appearance().backgroundColor = UIColor.init(40)
        UINavigationBar.appearance().barTintColor = UIColor.init(40)
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        UITabBar.appearance().backgroundColor = UIColor.init(40)
        UITabBar.appearance().barTintColor = UIColor(40)
    }
}
