//
//  HistoryTransactionTableViewCell.swift
//  MyMonee
//
//  Created by MacBook on 14/05/21.
//

import UIKit

class HistoryTransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var imageContainerCell: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageContainerCell.layer.cornerRadius = 4
        self.selectionStyle = .none

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

