//
//  ViewController.swift
//  Quotz
//
//  Created by Murilo da Silva Reigado on 06/03/24.
//

import UIKit

class MyQuotesViewController: UIViewController, MyQuotesPresenterDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var presenter: MyQuotesPresenter?
    
    //---------------------------------------------------------
    // MARK: Initializer
    //---------------------------------------------------------
    
    init() {
        super.init(nibName: "MyQuotesView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //---------------------------------------------------------
    // MARK: Life cycle
    //---------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MyQuotesPresenter(delegate: self)
        self.navigationController?.navigationBar.isHidden = true
        self.setupTableView()
    }
    
    //---------------------------------------------------------
    // MARK: Functions
    //---------------------------------------------------------
    
    func pushVC(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
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
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MyQuoteTableViewCell.nib(), forCellReuseIdentifier: MyQuoteTableViewCell.identifier)
    }
    
    
    //---------------------------------------------------------
    // MARK: IBAction
    //---------------------------------------------------------
    
    @IBAction func newQuoteTapped(_ sender: Any) {
        presenter?.openNewQuoteView()
    }
}

    //---------------------------------------------------------
    // MARK: Extension
    //---------------------------------------------------------

extension MyQuotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyQuoteTableViewCell.identifier, for: indexPath) as! MyQuoteTableViewCell
        if let myQuotes = getMyQuotes() {
            cell.dateLabel.text = myQuotes.date
            cell.quoteInLabel.text = "\(myQuotes.quoteIn) \(myQuotes.valueIn)"
            cell.quoteOutLabel.text = "\(myQuotes.quoteOut) \(myQuotes.valueOut)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

