//
//  QuoteViewController.swift
//  Quotz
//
//  Created by Murilo da Silva Reigado on 06/03/24.
//

import UIKit

class QuoteViewController: UIViewController, QuotePresenterDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var quoteInputLabel: UILabel!
    @IBOutlet weak var quoteOutputLabel: UILabel!
    @IBOutlet weak var quoteResult: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    
    
    var presenter: QuotePresenter?
    var quoteIn: String = ""
    var quoteOut: String = ""
    var dateFormatted: String = ""
    
    //---------------------------------------------------------
    // MARK: Initializer
    //---------------------------------------------------------
    
    init() {
        super.init(nibName: "QuoteView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //---------------------------------------------------------
    // MARK: Life cycle
    //---------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = QuotePresenter(delegate: self)
        self.navigationController?.navigationBar.isHidden = true
        self.setupUI()
        self.presenter?.getQuote(value: getQuote())
        self.setupTextField()
    }
    
    //---------------------------------------------------------
    // MARK: Functions
    //---------------------------------------------------------
    
    func pushVC(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setupUI() {
        
        self.quoteInputLabel.text = quoteIn
        self.quoteOutputLabel.text = quoteOut
        
        self.valueTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func setupTextField() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        valueTextField.delegate = self
        valueTextField.text = "0,00"
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        formatValue(textField)
        
        let txtValue = Double(textField.text ?? "")
        let quoteValue = Double(presenter?.quoteValue ?? "")
        
        if let value = txtValue, let quote = quoteValue {
            let multiply = value * quote
            let formated = String(format: "%.2f", multiply)
            let result = formated.replacingOccurrences(of: ".", with: ",")
            self.quoteResult.text = result
        }
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    func formatValue(_ textField: UITextField) {
        
        guard var textValue = textField.text else {
            return
        }
        
        textValue = textValue.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        if let number = Double(textValue) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            
            textValue = formatter.string(from: NSNumber(value: number/100)) ?? ""
            textField.text = textValue.replacingOccurrences(of: ",", with: ".")
        }
    }
    
    func getQuote() -> String {
        return "\(quoteIn)-\(quoteOut)"
    }
    
    func saveQuote(_ quote: MyQuotes) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(quote) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "savedQuote")
        }
    }
    
    func getDate() -> String {
        
        let actualDate = Date()
        let calendary = Calendar.current
        let component = calendary.dateComponents([.day, .month], from: actualDate)
        if let day = component.day {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM"
            let nomeMes = formatter.string(from: actualDate)
            self.dateFormatted = "\(day) \(nomeMes.uppercased())"
        }
        return dateFormatted
    }
    
    @IBAction func saveQuoteTapped(_ sender: Any) {
        let quote = MyQuotes(date: getDate(),
                             valueIn: valueTextField.text ?? "",
                             valueOut: quoteResult.text ?? "",
                             quoteIn: quoteIn,
                             quoteOut: quoteOut)
        saveQuote(quote)
        presenter?.openMyQuotesView()
    }
}
