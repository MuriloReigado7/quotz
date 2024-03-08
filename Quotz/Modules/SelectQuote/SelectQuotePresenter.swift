//
//  SelectQuotePresenter.swift
//  Quotz
//
//  Created by Murilo da Silva Reigado on 06/03/24.
//

import UIKit

protocol SelectQuotePresenterDelegate {
    func pushVC(_ viewController: UIViewController)
    func reloadData()
}

final class SelectQuotePresenter {
    
    public var delegate: SelectQuotePresenterDelegate?
    public var quotes: [String: String] = [:]
    
    init(delegate: SelectQuotePresenterDelegate) {
        self.delegate = delegate
    }
    
    //---------------------------------------------------------
    // MARK: API Request
    //---------------------------------------------------------
    
    func getQuote() {
        
        let apiUrl = URL(string: "https://economia.awesomeapi.com.br/json/available")!
        let session = URLSession.shared
        let task = session.dataTask(with: apiUrl) { (data, response, error) in
            
            if error != nil { return }
            
            guard let data = data else { return }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                    self.quotes = json
                    self.delegate?.reloadData()
                } else {
                    print("Erro ao decodificar os dados JSON.")
                }
            } catch {
                print("Erro ao processar os dados: \(error)")
            }
        }
        task.resume()
    }
    
    //---------------------------------------------------------
    // MARK: Navigation
    //---------------------------------------------------------
    
    func openQuoteResultView(quoteIn: String, quoteOut: String) {
        let quoteResultVC = QuoteViewController()
        quoteResultVC.quoteIn = quoteIn
        quoteResultVC.quoteOut = quoteOut
        delegate?.pushVC(quoteResultVC)
    }
}

