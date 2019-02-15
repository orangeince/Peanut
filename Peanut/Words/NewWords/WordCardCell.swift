//
//  WordCardCell.swift
//  Peanut
//
//  Created by 少 on 2018/12/14.
//  Copyright © 2018 ShaoZ. All rights reserved.
//

import UIKit
import VerticalCardSwiper

class WordCardCell: CardCell {
    @IBOutlet weak var wordLabel: UILabel!
    var didTappedInterpretationBtn: (()->())?

    public func setRandomBackgroundColor(isDark: Bool){

        let randomValue: ()->Int = {Int(arc4random() % 256)}
        
        var red = randomValue()
        var green = randomValue()
        var blue = randomValue()
        
        let isRightColor = { () -> Bool in
            let colorValue = CGFloat(red) * 0.299 + CGFloat(green) * 0.578 + CGFloat(blue) * 0.114
            return isDark ? colorValue >= 192 : colorValue < 192
        }
        
        while !isRightColor() {
            red = randomValue()
            green = randomValue()
            blue = randomValue()
        }

        self.backgroundColor = UIColor(r: red, g: green, b: blue)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 8
    }

    @IBAction func detailBtnTapped(_ sender: Any) {
        didTappedInterpretationBtn?()
    }
}
