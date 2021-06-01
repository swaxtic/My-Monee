//
//  ButtonView.swift
//  MyMonee
//
//  Created by MacBook on 16/05/21.
//

import UIKit
class ButtonView: UIButton {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var buttonView: UIButton!
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
        Bundle.main.loadNibNamed(String(describing: ButtonView.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        self.delegate?.buttonViewAction(sender: self)
    }
    
    private func appearance(){
        
    }
    
}
