//
//  CreateQuoteViewController.swift
//  Quotz
//
//  Created by Murilo da Silva Reigado on 06/03/24.
//

import UIKit

class CreateQuoteViewController: UIViewController, CreateQuotePresenterDelegate, UITextFieldDelegate {
    
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
    var quotesFilter = [String]()
    var quotesNameFilter = [String]()
    
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
        self.searchTextField.delegate = self
        self.presenter?.filterQuotes()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        presenter?.filterData(with: text)
        return true
    }
}

    //---------------------------------------------------------
    // MARK: Extension
    //---------------------------------------------------------

extension CreateQuoteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presenter?.quotesForFilter.count == 0 {
            return presenter?.quotes.count ?? 0
        } else {
            return presenter?.quotesForFilter.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CreateQuoteTableViewCell.identifier, for: indexPath) as! CreateQuoteTableViewCell
        
        if presenter?.quotesForFilter.count == 0 {
            cell.quoteLabel.text = getQuote()[indexPath.row]
            cell.quoteNameLabel.text = getQuoteName()[indexPath.row]
        } else {
            let value = presenter?.quotesForFilter[indexPath.row]
            cell.quoteLabel.text = value?.0
            cell.quoteNameLabel.text = value?.1
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if presenter?.quotesForFilter.count == 0 {
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
        } else {
            let value = presenter?.quotesForFilter[indexPath.row]
            if isFirstTouch {
                self.quoteInLabel.text = value?.0
                self.quoteIn = value?.0 ?? ""
                isFirstTouch = false
            } else {
                self.quoteOutLabel.text = value?.0
                self.quoteOut = value?.0 ?? ""
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.presenter?.openQuoteResultView(quoteIn: self.quoteIn, quoteOut: self.quoteOut)
                }
            }
        }
        animateView()
    }
}
