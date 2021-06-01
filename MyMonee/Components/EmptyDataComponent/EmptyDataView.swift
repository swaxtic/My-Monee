//
//  EmptyDataView.swift
//  MyMonee
//
//  Created by MacBook on 09/05/21.
//

import UIKit

class EmptyDataView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var buttonAdd: UIButton!
    
    var delegate: ButtonDelegate?
    
    // untuk view dibuat melalui program
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    // untuk view dibuat secara storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("EmptyDataView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        buttonAdd.backgroundColor = UIColor.init(named: "Main Blue Color")
        buttonAdd.layer.cornerRadius = 20
        buttonAdd.setTitleColor(UIColor.white, for: .normal)
        
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        self.delegate?.buttonViewAction(sender: buttonAdd)
    }
}
