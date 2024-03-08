//
//  DataManager.swift
//  Quotz
//
//  Created by Murilo da Silva Reigado on 08/03/24.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()

    private init() {}

    var userInformation: [MyQuotes] {
        get {
            if let data = UserDefaults.standard.data(forKey: "UserInformation"),
               let savedInformation = try? JSONDecoder().decode([MyQuotes].self, from: data) {
                return savedInformation
            }
            return []
        }
        set {
            if let encodedData = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encodedData, forKey: "UserInformation")
            }
        }
    }

    func saveInformation() {
        UserDefaults.standard.set(try? JSONEncoder().encode(userInformation), forKey: "UserInformation")
    }
}
