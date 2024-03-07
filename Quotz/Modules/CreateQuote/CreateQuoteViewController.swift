//
//  CreateQuoteViewController.swift
//  Quotz
//
//  Created by Murilo da Silva Reigado on 06/03/24.
//

import UIKit

class CreateQuoteViewController: UIViewController, CreateQuotePresenterDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var quoteView: UIView!
    @IBOutlet weak var quoteViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var quoteInLabel: UILabel!
    @IBOutlet weak var quoteOutLabel: UILabel!
    
    var presenter: CreateQuotePresenter?
    var isFirstTouch = true
    var quoteIn = ""
    var quoteOut = ""
    
    //---------------------------------------------------------
    // MARK: Initializer
    //---------------------------------------------------------
    
    init() {
        super.init(nibName: "CreateQuoteView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //---------------------------------------------------------
    // MARK: Life cycle
    //---------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter?.getQuotes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = CreateQuotePresenter(delegate: self)
        self.navigationController?.navigationBar.isHidden = true
        self.setupTableView()
        self.setupUI()
    }
    
    //---------------------------------------------------------
    // MARK: Functions
    //---------------------------------------------------------
    
    func setupUI() {
        self.quoteViewHeight.constant = 0
        self.tableViewTopConstraint.constant = 0
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CreateQuoteTableViewCell.nib(), forCellReuseIdentifier: CreateQuoteTableViewCell.identifier)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func pushVC(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func animateView() {
        UIView.animate(withDuration: 0.8) {
            self.quoteViewHeight.constant = 57
            self.tableViewTopConstraint.constant = 15
            self.quoteView.alpha = 1.0
            self.titleLabel.text = "Selecione outra moeda"
            self.view.layoutIfNeeded()
        }
    }
    
    func getQuote() -> [String] {
        
        var dictionaryKeys: [String] {
            if let key = presenter?.quotes.keys {
                return Array(key)
            }
            return [""]
        }
        return dictionaryKeys
    }
    
    func getQuoteName() -> [String] {
        
        var dictionaryKeys: [String] {
            if let key = presenter?.quotes.values {
                return Array(key)
            }
            return [""]
        }
        return dictionaryKeys
    }

}

    //---------------------------------------------------------
    // MARK: Extension
    //---------------------------------------------------------

extension CreateQuoteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.quotes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CreateQuoteTableViewCell.identifier, for: indexPath) as! CreateQuoteTableViewCell
        cell.quoteLabel.text = getQuote()[indexPath.row]
        cell.quoteNameLabel.text = getQuoteName()[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFirstTouch {
            self.quoteInLabel.text = getQuote()[indexPath.row]
            self.quoteIn = getQuote()[indexPath.row]
            isFirstTouch = false
        } else {
            self.quoteOutLabel.text = getQuote()[indexPath.row]
            self.quoteOut = getQuote()[indexPath.row]
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.presenter?.openQuoteResultView(quoteIn: self.quoteIn, quoteOut: self.quoteOut)
            }
        }
        animateView()
    }
}
