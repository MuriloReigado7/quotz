//
//  Quotes.swift
//  Quotz
//
//  Created by Murilo da Silva Reigado on 08/03/24.
//

import Foundation

struct Quotes: Codable {
    
    var myQuotes: [MyQuotes]

    init(myQuotes: [MyQuotes]) {
        self.myQuotes = myQuotes
    }
}
