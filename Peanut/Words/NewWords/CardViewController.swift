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
    fileprivate let wordStore: WordStore
    var words: [Word] {
        return wordStore.learnWords
    }
    let didSelectedWord: ((Word) -> Void)?
    private var cardSwiper: VerticalCardSwiper!

    init(wordStore: WordStore, didSelectedWord: ((Word) -> Void)?) {
        self.wordStore = wordStore
        self.didSelectedWord = didSelectedWord
        super.init(nibName: nil, bundle: nil)

        wordStore.didChangedWords = { [weak self] words in
            guard let `self` = self else {
                return
            }
            self.cardSwiper.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        cardSwiper = VerticalCardSwiper()
        //cardSwiper.isSideSwipingEnabled = false
        view.addSubview(cardSwiper)
        cardSwiper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(
            item: cardSwiper,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: cardSwiper,
            attribute: .leading,
            relatedBy: .equal,
            toItem: view,
            attribute: .leading,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: cardSwiper,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: view,
            attribute: .trailing,
            multiplier: 1,
            constant: 0).isActive = true
        NSLayoutConstraint(
            item: cardSwiper,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 1,
            constant: 0).isActive = true
        
        cardSwiper.datasource = self
        cardSwiper.delegate = self
        cardSwiper.topInset = 0
        
        cardSwiper.register(nib: UINib(nibName: "WordCardCell", bundle: nil), forCellWithReuseIdentifier: "WordCell")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()

        observe(theme: \AppTheme.collectionView)
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "WordCell", for: index) as! WordCardCell
        cardCell.setRandomBackgroundColor()
        let word = words[index]
        cardCell.wordLabel.text = word.content
        cardCell.didTappedInterpretationBtn = { [weak self] in
            self?.didSelectedWord?(word)
        }
        return cardCell
    }
    
    func didSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        let word = words[index]
        wordStore.acquire(word: word)
    }
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return words.count
    }
}

extension CardViewController: Themeable {
    typealias Theme = CollectionViewTheme
    
    func apply(theme: Theme) {
        view.backgroundColor = theme.backgroundColor
    }
}
