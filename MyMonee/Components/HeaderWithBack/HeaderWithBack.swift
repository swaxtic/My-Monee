//
//  HeaderWithBack.swift
//  MyMonee
//
//  Created by MacBook on 16/05/21.
//

import UIKit

class HeaderWithBack: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var delegate: ButtonDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit(){
        
        Bundle.main.loadNibNamed(String(describing: HeaderWithBack.self), owner: self, options: nil)
        
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        Helper.setTagButton(buttonView: backButton, typeButton: .backButton)
        
    }
    @IBAction func buttonAction(_ sender: Any) {
        self.delegate?.buttonViewAction(sender: backButton)
    }
    
}
