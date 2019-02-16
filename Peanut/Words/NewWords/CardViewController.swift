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
    private lazy var emptyView = EmptyView()

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
        
        view.addSubview(emptyView)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        emptyView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        emptyView.isHidden = !words.isEmpty

        observe(theme: \AppTheme.collectionView)
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "WordCell", for: index) as! WordCardCell
        cardCell.setRandomBackgroundColor(isDark: !ThemeManager.default.isDark)
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
        emptyView.isHidden = !words.isEmpty
    }
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return words.count
    }
}

extension CardViewController {
    fileprivate class EmptyView: UIView {
        private let imageView = UIImageView(image: UIImage(named: "icon_empty"))
        private let titleLabel = UILabel()
        
        init() {
            super.init(frame: .zero)
            setupSubviews()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupSubviews() {
            addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -120).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
            
            addSubview(titleLabel)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 12)
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
            // TODO: 空页面的标题应该是根据上下文配置的
            titleLabel.text = "没有需要复习的单词"
            titleLabel.font = UIFont.systemFont(ofSize: 16)
            titleLabel.textColor = UIColor(r: 102, g: 102, b: 102)
        }
    }
}

extension CardViewController: Themeable {
    typealias Theme = CollectionViewTheme
    
    func apply(theme: Theme) {
        view.backgroundColor = theme.backgroundColor
    }
}
