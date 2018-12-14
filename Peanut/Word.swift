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
}


extension Date {
    func formattedString(_ formatter: String = "MM-dd HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
}
