//
//  SelectQuoteTableViewCell.swift
//  Quotz
//
//  Created by Murilo da Silva Reigado on 06/03/24.
//

import UIKit

class SelectQuoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coinImput: UILabel!
    @IBOutlet weak var coinOutput: UILabel!
    
    static let identifier = "SelectQuoteTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "SelectQuoteTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
