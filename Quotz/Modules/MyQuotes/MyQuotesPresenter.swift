//
//  HomeViewModel.swift
//  Study
//
//  Created by Murilo da Silva Reigado on 26/01/24.
//

import UIKit

protocol MyQuotesPresenterDelegate {
    func pushVC(_ viewController: UIViewController)
}

final class MyQuotesPresenter {
    
    public var delegate: MyQuotesPresenterDelegate?
    
    init(delegate: MyQuotesPresenterDelegate) {
        self.delegate = delegate
    }
    
    func openNewQuoteView() {
        let newQuoteVC = NewQuoteViewController()
        delegate?.pushVC(newQuoteVC)
    }
}
