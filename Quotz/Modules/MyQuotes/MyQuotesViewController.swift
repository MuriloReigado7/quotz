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
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MyQuoteTableViewCell.nib(), forCellReuseIdentifier: MyQuoteTableViewCell.identifier)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let userInfo = DataManager.shared.userInformation
        return userInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyQuoteTableViewCell.identifier, for: indexPath) as! MyQuoteTableViewCell
        let userInfo = DataManager.shared.userInformation[indexPath.row]
        cell.dateLabel.text = userInfo.date
        cell.quoteInLabel.text = "\(userInfo.quoteIn) \(userInfo.valueIn)"
        cell.quoteOutLabel.text = "\(userInfo.quoteOut) \(userInfo.valueOut)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

