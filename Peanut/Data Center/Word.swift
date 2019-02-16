//
//  Word.swift
//  Peanut
//
//  Created by 少 on 2018/12/9.
//  Copyright © 2018 ShaoZ. All rights reserved.
//

import Foundation

struct Word {
    let content: String
    let createdAt: Date
    var lastModifiedAt: Date = Date()
    var markTimes: Int = 0
    
    init(content: String, createdAt: Date) {
        self.content = content
        self.createdAt = createdAt
    }
}

extension Word: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(content)
    }
    
    public static func == (lhs: Word, rhs: Word) -> Bool {
        return lhs.content == rhs.content
    }
}

extension Date {
    func formattedString(_ formatter: String = "MM-dd HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
}
