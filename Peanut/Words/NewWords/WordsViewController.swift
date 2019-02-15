//
//  WordsViewController.swift
//  Peanut
//
//  Created by 少 on 2019/2/15.
//  Copyright © 2019 ShaoZ. All rights reserved.
//

import UIKit
import Gestalt

class WordsViewController: UIViewController {
    private var segment: UISegmentedControl!
    private let cardVC: CardViewController
    private let allWordsVC: AllWordsViewController
    private var containerView: UIView!
    
    init(cardVC: CardViewController, allWordsVC: AllWordsViewController) {
        self.cardVC = cardVC
        self.allWordsVC = allWordsVC
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        segment = UISegmentedControl(items: ["复习", "全部"])
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.selectedSegmentIndex = 0
        view.addSubview(segment)
        segment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        segment.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        segment.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        segment.heightAnchor.constraint(equalToConstant: 32)
        segment.addTarget(self, action: #selector(didSegmentChanged), for: .valueChanged)
        
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: 16).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc
    private func didSegmentChanged() {
        switch segment.selectedSegmentIndex {
        case 0:
            setupChild(cardVC)
        case 1:
            setupChild(allWordsVC)
        default:
            fatalError("not cover this logic")
        }
    }
    
    private func setupChild(_ vc: UIViewController) {
        guard vc.view.superview == nil else {
            return
        }
        if let child = children.first {
            child.removeFromParent()
            child.view.removeFromSuperview()
        }
        addChild(vc)
        containerView.addSubview(vc.view)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        vc.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        vc.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        vc.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        
        observe(theme: \AppTheme.collectionView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addBtnTapped)
        )
        segment.selectedSegmentIndex = 0
        didSegmentChanged()
    }
    
    @objc
    func addBtnTapped() {
        UIAlertController.show(message: "Not yet implement!", title: "喵")
    }
}

extension WordsViewController: Themeable {
    typealias Theme = CollectionViewTheme
    
    func apply(theme: Theme) {
        view.backgroundColor = theme.backgroundColor
    }
}
