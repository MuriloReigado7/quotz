//
//  MyQuoteTableViewCell.swift
//  Quotz
//
//  Created by Murilo da Silva Reigado on 07/03/24.
//

import UIKit

class MyQuoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var quoteOutLabel: UILabel!
    @IBOutlet weak var quoteInLabel: UILabel!
    
    static let identifier = "MyQuoteTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MyQuoteTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
