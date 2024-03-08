//
//  HomeViewModel.swift
//  Study
//
//  Created by Murilo da Silva Reigado on 26/01/24.
//

import UIKit

protocol MyQuotesPresenterDelegate {
    func pushVC(_ viewController: UIViewController)
    func reloadData()
}

final class MyQuotesPresenter {
    
    public var delegate: MyQuotesPresenterDelegate?
    public var quotes: [MyQuotes] = []
    
    init(delegate: MyQuotesPresenterDelegate) {
        self.delegate = delegate
    }
    
    //---------------------------------------------------------
    // MARK: Navigation
    //---------------------------------------------------------
    
    func openNewQuoteView() {
        let newQuoteVC = NewQuoteViewController()
        delegate?.pushVC(newQuoteVC)
    }
}
