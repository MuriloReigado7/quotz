//
//  NewQuoteViewController.swift
//  Quotz
//
//  Created by Murilo da Silva Reigado on 06/03/24.
//

import UIKit

class NewQuoteViewController: UIViewController, NewQuotePresenterDelegate {

    var presenter: NewQuotePresenter?
    
    //---------------------------------------------------------
    // MARK: Initializer
    //---------------------------------------------------------
    
    init() {
        super.init(nibName: "NewQuoteView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //---------------------------------------------------------
    // MARK: Life cycle
    //---------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = NewQuotePresenter(delegate: self)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //---------------------------------------------------------
    // MARK: Functions
    //---------------------------------------------------------
    
    func pushVC(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    //---------------------------------------------------------
    // MARK: IBAction
    //---------------------------------------------------------
    
    @IBAction func selectQuoteTapped(_ sender: Any) {
        presenter?.openSelectQuoteView()
    }
    
    @IBAction func createQuoteTapped(_ sender: Any) {
        presenter?.openCreateQuoteView()
    }
}
