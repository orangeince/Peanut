//
//  CardViewController.swift
//  Peanut
//
//  Created by 少 on 2018/12/14.
//  Copyright © 2018 ShaoZ. All rights reserved.
//

import UIKit
import VerticalCardSwiper
import Gestalt

class CardViewController: UIViewController, VerticalCardSwiperDatasource, VerticalCardSwiperDelegate {
    fileprivate var words: [Word]
    let didSelectedWord: ((Word) -> Void)?
    private var cardSwiper: VerticalCardSwiper!

    init(wordStore: WordStore, didSelectedWord: ((Word) -> Void)?) {
        self.words = wordStore.words
        self.didSelectedWord = didSelectedWord
        super.init(nibName: nil, bundle: nil)
        title = "Words"
        
        wordStore.didChangedWords = { [weak self] words in
            guard let `self` = self else {
                return
            }
            self.words = words
            self.cardSwiper.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardSwiper = VerticalCardSwiper(frame: self.view.bounds)
        cardSwiper.isSideSwipingEnabled = false
        view.addSubview(cardSwiper)
        cardSwiper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: cardSwiper, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: cardSwiper, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: cardSwiper, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: cardSwiper, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        cardSwiper.datasource = self
        cardSwiper.delegate = self
        
        //cardSwiper.register(WordCardCell.self, forCellWithReuseIdentifier: "card")
        cardSwiper.register(nib: UINib(nibName: "WordCardCell", bundle: nil), forCellWithReuseIdentifier: "WordCell")
        
        observe(theme: \AppTheme.collectionView)
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "WordCell", for: index) as! WordCardCell
        cardCell.setRandomBackgroundColor()
        cardCell.wordLabel.text = words[index].content
        return cardCell
    }
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return words.count
    }
    
    func didTapCard(verticalCardSwiperView: VerticalCardSwiperView, index: Int) {
        let word = words[index]
        didSelectedWord?(word)
    }
    
}

extension CardViewController: Themeable {
    typealias Theme = CollectionViewTheme
    
    func apply(theme: Theme) {
        view.backgroundColor = theme.backgroundColor
    }
}
