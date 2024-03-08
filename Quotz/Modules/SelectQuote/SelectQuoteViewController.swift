//
//  SelectQuoteViewController.swift
//  Quotz
//
//  Created by Murilo da Silva Reigado on 06/03/24.
//

import UIKit

class SelectQuoteViewController: UIViewController, SelectQuotePresenterDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: SelectQuotePresenter?
    var allQuotes = [String]()
    
    //---------------------------------------------------------
    // MARK: Initializer
    //---------------------------------------------------------
    
    init() {
        super.init(nibName: "SelectQuoteView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //---------------------------------------------------------
    // MARK: Life cycle
    //---------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter?.getQuote()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = SelectQuotePresenter(delegate: self)
        self.navigationController?.navigationBar.isHidden = true
        self.setupTableView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //---------------------------------------------------------
    // MARK: Functions
    //---------------------------------------------------------
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SelectQuoteTableViewCell.nib(), forCellReuseIdentifier: SelectQuoteTableViewCell.identifier)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func pushVC(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    //---------------------------------------------------------
    // MARK: IBOutlets
    //---------------------------------------------------------
    
    @IBAction func searchHandler(_ sender: UITextField) {
        if let searchText = sender.text {
            allQuotes = presenter?.getCharactersBeforeHyphen().filter{$0.lowercased().contains(searchText.lowercased())} ?? [""]
            tableView.reloadData()
        }
    }
}

    //---------------------------------------------------------
    // MARK: Extension
    //---------------------------------------------------------

extension SelectQuoteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allQuotes.isEmpty {
            return presenter?.quotes.keys.count ?? 0
        } else {
            return allQuotes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectQuoteTableViewCell.identifier, for: indexPath) as! SelectQuoteTableViewCell
        if allQuotes.isEmpty {
            cell.coinImput.text = presenter?.getCharactersBeforeHyphen()[indexPath.row]
        } else {
            cell.coinImput.text = allQuotes[indexPath.row]
        }
        cell.coinOutput.text = presenter?.getCharactersAfterHyphen()[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if allQuotes.isEmpty {
            presenter?.openQuoteResultView(quoteIn: presenter?.getCharactersBeforeHyphen()[indexPath.row] ?? "", quoteOut: presenter?.getCharactersAfterHyphen()[indexPath.row] ?? "")
        } else {
            presenter?.openQuoteResultView(quoteIn: allQuotes[indexPath.row], quoteOut: presenter?.getCharactersAfterHyphen()[indexPath.row] ?? "")
        }
        
    }
}
