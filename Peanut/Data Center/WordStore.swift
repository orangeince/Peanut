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
    lazy private(set) var learnWords: [Word] = Array(words.prefix(5))
    init() {
        // TODO: do something
        words = [
            Word(content: "peanut", createdAt: Date()),
            Word(content: "acquired", createdAt: Date()),
            Word(content: "physical", createdAt: Date()),
            Word(content: "creativity", createdAt: Date()),
            Word(content: "evaporation", createdAt: Date()),
            Word(content: "conformity", createdAt: Date()),
            Word(content: "disadvantage", createdAt: Date()),
            Word(content: "diagram", createdAt: Date()),
        ]
    }
    
    func acquire(word: Word) {
        if let idx = learnWords.index(of: word) {
            learnWords.remove(at: idx)
        }
    }
    
    func fetchWords(sortedBy type: WordSortedType) -> [Word] {
        return words.sorted(by: {
            return type == .char ? $0.content < $1.content : $0.createdAt < $1.createdAt
        })
    }
}

enum WordSortedType: Int {
    case char
    case modified
}
