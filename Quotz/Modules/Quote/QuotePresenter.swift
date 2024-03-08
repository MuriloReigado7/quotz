//
//  QuotePresenter.swift
//  Quotz
//
//  Created by Murilo da Silva Reigado on 06/03/24.
//

import UIKit

protocol QuotePresenterDelegate {
    func pushVC(_ viewController: UIViewController)
}

final class QuotePresenter {
    
    public var delegate: QuotePresenterDelegate?
    public var quoteValue: String = ""
    
    init(delegate: QuotePresenterDelegate) {
        self.delegate = delegate
    }
    
    //---------------------------------------------------------
    // MARK: API Request
    //---------------------------------------------------------
    
    func getQuote(value: String) {
        
        let apiUrl = URL(string: "https://economia.awesomeapi.com.br/last/\(value)")!
        let session = URLSession.shared
        let task = session.dataTask(with: apiUrl) { (data, response, error) in
            
            if error != nil { return }
            
            if let data = data {
                do {
                    if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let quote = jsonObject[value.replacingOccurrences(of: "-", with: "")] as? [String: String] {
                            if let value = quote["ask"] {
                                self.quoteValue = value
                            }
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    //---------------------------------------------------------
    // MARK: Navigation
    //---------------------------------------------------------
    
    func openMyQuotesView() {
        let myQuotesVC = MyQuotesViewController()
        delegate?.pushVC(myQuotesVC)
    }
}
