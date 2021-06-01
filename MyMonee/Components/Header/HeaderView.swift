//
//  HeaderView.swift
//  MyMonee
//
//  Created by MacBook on 13/05/21.
//

import UIKit

//protocol HeaderRightButtonDelegate {
//    func headerRightButtonAction()
//}

class HeaderView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerText: UILabel!
    @IBOutlet weak var headerRightButton: UIButton!
    @IBOutlet weak var headerUserName: UILabel!
    var delegate: ButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) { 
        super.init(coder: coder)
        self.commonInit()
        greeting()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed(String(describing: HeaderView.self), owner: self, options: nil)
       
        addSubview(contentView)
        contentView.frame = self.bounds
        headerRightButton.layer.cornerRadius = 18
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        headerRightButton.tintColor = UIColor(named: "Blue Tab Bar Color")
    }
    
    private func greeting() {
        let date = NSDate()
        let calendar = NSCalendar.current
        let currentHour = calendar.component(.hour, from: date as Date)
        let hourInt = Int(currentHour.description)!

        if hourInt >= 12 && hourInt <= 14 {
            headerText.text = "Selamat Siang,"
        }
        else if hourInt >= 5 && hourInt <= 12 {
            headerText.text = "Selamat Pagi,"
        }
        else if hourInt >= 15 && hourInt <= 18 {
            headerText.text = "Selamat Sore,"
        }
        else if hourInt >= 18 && hourInt <= 24 {
            headerText.text = "Selamat Malam,"
        }
        else if hourInt >= 0 && hourInt <= 5 {
            headerText.text = "Selamat Dini Hari,"
        }
    }

    @IBAction func buttonAction(_ sender: Any) {
        self.delegate?.buttonViewAction(sender: headerRightButton)
    }
}
