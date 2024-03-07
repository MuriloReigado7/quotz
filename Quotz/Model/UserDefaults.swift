//
//  UserDefaults.swift
//  Quotz
//
//  Created by Murilo da Silva Reigado on 07/03/24.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    
    func saveQuote(_ quote: MyQuotes) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(quote) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "savedQuote")
        }
    }
    
    func getMyQuotes() -> MyQuotes? {
        let defaults = UserDefaults.standard
        if let savedQuote = defaults.object(forKey: "savedQuote") as? Data {
            let decoder = JSONDecoder()
            if let getQuote = try? decoder.decode(MyQuotes.self, from: savedQuote) {
                return getQuote
            }
        }
        return nil
    }
}
