//
//  CreateQuoteTableViewCell.swift
//  Quotz
//
//  Created by Murilo da Silva Reigado on 07/03/24.
//

import UIKit

class CreateQuoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var quoteNameLabel: UILabel!
    
    static let identifier = "CreateQuoteTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CreateQuoteTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
