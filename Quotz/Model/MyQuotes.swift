//
//  MyQuotes.swift
//  Quotz
//
//  Created by Murilo da Silva Reigado on 07/03/24.
//

import Foundation

class MyQuotes: Codable {
    
    var date: String
    var valueIn: String
    var valueOut: String
    var quoteIn: String
    var quoteOut: String

    init(date: String, valueIn: String, valueOut: String, quoteIn: String, quoteOut: String) {
        
        self.date = date
        self.valueIn = valueIn
        self.valueOut = valueOut
        self.quoteIn = quoteIn
        self.quoteOut = quoteOut
    }
}
