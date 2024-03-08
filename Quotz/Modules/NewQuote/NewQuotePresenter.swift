//
//  NewQuotePresenter.swift
//  Quotz
//
//  Created by Murilo da Silva Reigado on 06/03/24.
//

import UIKit

protocol NewQuotePresenterDelegate {
    func pushVC(_ viewController: UIViewController)
}

final class NewQuotePresenter {
    
    public var delegate: NewQuotePresenterDelegate?
    
    init(delegate: NewQuotePresenterDelegate) {
        self.delegate = delegate
    }
    
    //---------------------------------------------------------
    // MARK: Navigation
    //---------------------------------------------------------
    
    func openSelectQuoteView() {
        let selectQuoteVC = SelectQuoteViewController()
        delegate?.pushVC(selectQuoteVC)
    }
    
    func openCreateQuoteView() {
        let createQuoteVC = CreateQuoteViewController()
        delegate?.pushVC(createQuoteVC)
    }
}
