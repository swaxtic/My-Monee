//
//  ImpianTableViewCell.swift
//  MyMonee
//
//  Created by MacBook on 15/05/21.
//

import UIKit

class ImpianTableViewCell: UITableViewCell {

    @IBOutlet weak var tableViewCell: UIView!
    @IBOutlet weak var impianTitleLable: UILabel!
    @IBOutlet weak var impianProgress: UIProgressView!
    @IBOutlet weak var impianBottomText: UILabel!
    @IBOutlet weak var buttonSelesai: UIButton!
    @IBOutlet weak var buttonHapus: UIButton!
    
    var delegate: ButtonCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableViewCell.layer.cornerRadius = 4
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonHapusAction(_ sender: Any) {
        self.delegate?.buttonCellDelete(sender: buttonHapus)
    }
    
    @IBAction func buttonSelesaiAction(_ sender: Any) {
        self.delegate?.buttonCellDone(sender: buttonSelesai)
    }
}
