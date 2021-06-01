//
//  Helper.swift
//  MyMonee
//
//  Created by MacBook on 15/05/21.
//

import Foundation
import UIKit

class Helper {
    
    static let DELAY_SHORT = 1.5
    static let DELAY_LONG = 3.0
    
    static func setHeaderWithGreeting(headerUsername: String, imageName: String, headerComponent: HeaderView, titleButton: String) {
        //headerComponent.headerText.text = headertext
        headerComponent.headerUserName.text = headerUsername
        headerComponent.headerRightButton.setImage(UIImage(named: imageName), for: .normal)
        headerComponent.headerRightButton.setTitle(titleButton, for: .normal)
    }
    
    static func setHeaderWithoutGreeting(imageName: String, headerComponent: HeaderView, titleButton: String) {
        headerComponent.headerText.text = ""
        headerComponent.headerUserName.text = ""
        headerComponent.headerRightButton.setImage(UIImage(named: imageName), for: .normal)
        headerComponent.headerRightButton.setTitle(titleButton, for: .normal)
    }
    
    static func roundCornerTop(radius: CGFloat, uiView: UIView){
        uiView.clipsToBounds = true
        uiView.layer.cornerRadius = radius
        uiView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    static func registerTable(table: UITableView, dataSource: UITableViewDataSource, delegate: UITableViewDelegate, cellClass: AnyClass){
        table.dataSource = dataSource
        table.delegate = delegate
        
        let uiNib = UINib(nibName: String(describing: cellClass.self), bundle: nil)
        table.register(uiNib, forCellReuseIdentifier: String(describing: cellClass.self))
    }
    
    static func registerCollectionView(collectionView: UICollectionView, dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate, cellClass: AnyClass){
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        
        let uiNib = UINib(nibName: String(describing: cellClass.self), bundle: nil)
        collectionView.register(uiNib, forCellWithReuseIdentifier: String(describing: cellClass.self))
        
    }
    
    static func dropShadowEffect(uiView: UIView){
        uiView.layer.shadowOpacity = 0.35
        uiView.layer.shadowOffset = CGSize(width: 0, height: 2)
        uiView.layer.shadowRadius = 3.0
        uiView.layer.shadowColor = UIColor.darkGray.cgColor
    }
    
    static func setTagButton(buttonView: UIButton, typeButton: ButtonTag){
        buttonView.tag = typeButton.rawValue
    }
    
    static func setButtonState(isEnabled: Bool, buttonView: UIView, button: UIButton){
        if isEnabled {
            buttonView.backgroundColor = UIColor.init(named: "Main Blue Color")
            button.isEnabled = isEnabled
        }else{
            buttonView.backgroundColor = UIColor.init(named: "Disabled Button")
            button.isEnabled = isEnabled
        }
    }
    
    static func setBorderButton(button: UIButton){
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.init(named: "Main Blue Color")?.cgColor
    }
    
    static func setDeleteButton(button: UIButton, title: String){
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.init(named: "Red")?.cgColor
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.init(named: "Red"), for: .normal)
    }
    
    static func clearBorderButton(button: UIButton){
        button.layer.borderWidth = 0
    }
    
    static func generateId() -> String{
          let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<6).map{ _ in letters.randomElement()! })
    }
    
    static func setEmptyDataComponent(text: String, emptyDataView: EmptyDataView, titleButton: String) {
        emptyDataView.mainLabel.text = text
        emptyDataView.buttonAdd.setTitle(titleButton, for: .normal)
    }
    
    static func showToast(_ text: String, delay: TimeInterval = DELAY_LONG) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        let label = UILabel()
        label.backgroundColor = UIColor(white: 0, alpha: 0.5)
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.alpha = 0
        label.text = text
        label.numberOfLines = 0
        
        var vertical: CGFloat = 0
        var size = label.intrinsicContentSize
        var width = min(size.width, window.frame.width - 30)
        if width != size.width {
            vertical = 10
            label.textAlignment = .justified
        }
        
        size = label.intrinsicContentSize
        width = min(size.width, window.frame.width - 100)
        
        label.frame = CGRect(x: 20, y: window.frame.height - 90, width: width + 20, height: size.height + 20)
        label.center.x = window.center.x
        //label.layer.cornerRadius = min(label.frame.height/2, 25)
        label.layer.masksToBounds = true
        window.addSubview(label)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            label.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: delay, options: .curveEaseOut, animations: {
                label.alpha = 0
            }, completion: {_ in
                label.removeFromSuperview()
            })
        })
    }
}
