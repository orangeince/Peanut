//
//  WordStore.swift
//  Peanut
//
//  Created by 少 on 2018/12/16.
//  Copyright © 2018 ShaoZ. All rights reserved.
//

import Foundation

class WordStore {
    static let shared: WordStore = WordStore()
    var didChangedWords: (([Word]) -> Void)?
    
    private(set) var words: [Word] = []
    init() {
        // TODO: do something
        words = [
            Word(content: "peanut", createdAt: Date()),
            Word(content: "prefer", createdAt: Date()),
            Word(content: "physical", createdAt: Date())
        ]
    }
}
