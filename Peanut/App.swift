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
    let navigationController: UINavigationController
    
    init(window: UIWindow) {
        let words = [
            Word(content: "peanut", createdAt: Date())
        ]
        let wordsVC = ItemsViewController(items: words) { (cell: WordCell, word) in
            cell.textLabel?.text = word.content
            cell.detailTextLabel?.text = word.createdAt.formattedString()
        }
        wordsVC.title = "Words"
        navigationController = UINavigationController(rootViewController: wordsVC)
        window.rootViewController = navigationController
        wordsVC.didSelectedItem = showInterpretation
    }
    
    func showInterpretation(word: Word) {
        let vc = UIReferenceLibraryViewController(term: word.content)
        vc.title = word.content
        //navigationController.pushViewController(vc, animated: true)
        navigationController.present(vc, animated: true, completion: nil)
    }
}
