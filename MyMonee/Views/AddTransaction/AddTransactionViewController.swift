//
//  AddTransactionViewController.swift
//  MyMonee
//
//  Created by MacBook on 16/05/21.
//

import UIKit

class AddTransactionViewController: UIViewController, ButtonDelegate {
    
    @IBOutlet weak var saveButtonComponent: ButtonView!
    @IBOutlet weak var headerComponent: HeaderWithBack!
    @IBOutlet weak var pemasukanChoice: UIButton!
    @IBOutlet weak var pengeluaranChoice: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    var transactionType: TransactionType!
    var service : TransactionServices = TransactionServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAppearance()
        
        saveButtonComponent.delegate = self
        headerComponent.delegate = self
        
        Helper.setTagButton(buttonView: saveButtonComponent, typeButton: .saveButton)
        titleTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        amountTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)

    }
    
    private func loadAppearance(){
        headerComponent.titleLabel.text = "Tambah Penggunaan"
        
        saveButtonComponent.buttonView.layer.cornerRadius = 20
        saveButtonComponent.buttonView.setTitle("Simpan", for: .normal)
        saveButtonComponent.buttonView.setTitleColor(UIColor.white, for: .normal)
        
        if pemasukanChoice.isSelected || pengeluaranChoice.isSelected {
            Helper.setButtonState(isEnabled: true, buttonView: saveButtonComponent.buttonView, button: saveButtonComponent)
        }else{
            Helper.setButtonState(isEnabled: false, buttonView: saveButtonComponent.buttonView, button: saveButtonComponent)
        }
        
        centerButtonImageAndTitle(button: pemasukanChoice)
        centerButtonImageAndTitle(button: pengeluaranChoice)
        
        pengeluaranChoice.backgroundColor = UIColor.white
        Helper.dropShadowEffect(uiView: pengeluaranChoice)
        pengeluaranChoice.layer.cornerRadius = 8.0
        
        pemasukanChoice.backgroundColor = UIColor.white
        Helper.dropShadowEffect(uiView: pemasukanChoice)
        pemasukanChoice.layer.cornerRadius = 8.0
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if titleTextField.text?.isEmpty ?? false || amountTextField.text?.isEmpty ?? false || transactionType == nil {
            Helper.setButtonState(isEnabled: false, buttonView: saveButtonComponent.buttonView, button: saveButtonComponent)
        }else if(transactionType == nil){
            Helper.setButtonState(isEnabled: true, buttonView: saveButtonComponent.buttonView, button: saveButtonComponent)
        }
    }
    
    private func centerButtonImageAndTitle (button: UIButton) {
        let spacing: CGFloat = 6.0
        let imageSize = button.imageView!.frame.size
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0)
        let titleSize = button.titleLabel!.frame.size
        button.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
    }
    // MARK: -Button Action
    func buttonViewAction(sender: UIButton) {
        switch sender.tag {
        case ButtonTag.backButton.rawValue:
            self.navigationController?.popViewController(animated: true)
        case ButtonTag.saveButton.rawValue:
            saveData()
        default:
            print("default")
        }
    }
    
    func saveData() {
        let currentDate = dateFormatter()
        let id = Helper.generateId()
        service.postTransaction(uploadDataModel: TransactionResponse(id: id, title: titleTextField.text!, amount: Double(amountTextField.text!) ?? 0.0, type: transactionType.rawValue, date: currentDate)) {
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                Helper.showToast("SUCCESS", delay: 10)
                //Helper.showToast("Success Updated Data")
            }
        }
        print("Success Add To Array")
    }
    func popToView(animated: Bool, completion: @escaping () -> ()){
        self.navigationController?.popViewController(animated: animated)
        completion()
    }
    
    @IBAction func pengeluaranButtonPressed(_ sender: Any) {
        if let button = sender as? UIButton {
            if button.isSelected {
                button.isSelected = false
                Helper.clearBorderButton(button: button)
                Helper.setButtonState(isEnabled: false, buttonView: saveButtonComponent.buttonView, button: saveButtonComponent)
            } else {
                button.isSelected = true
                transactionType = .debit
                pemasukanChoice.isSelected = false
                Helper.setBorderButton(button: button)
                Helper.clearBorderButton(button: pemasukanChoice)
                Helper.setButtonState(isEnabled: true, buttonView: saveButtonComponent.buttonView, button: saveButtonComponent)
            }
        }
    }
    
    @IBAction func pemasukkanButtonPressed(_ sender: Any) {
        if let button = sender as? UIButton {
            if button.isSelected {
                button.isSelected = false
                Helper.clearBorderButton(button: button)
                Helper.setButtonState(isEnabled: false, buttonView: saveButtonComponent.buttonView, button: saveButtonComponent)
            } else {
                button.isSelected = true
                transactionType = .credit
                pengeluaranChoice.isSelected = false
                Helper.setBorderButton(button: button)
                Helper.clearBorderButton(button: pengeluaranChoice)
                Helper.setButtonState(isEnabled: true, buttonView: saveButtonComponent.buttonView, button: saveButtonComponent)
            }
        }
    }
}
extension AddTransactionViewController: DateIdFormatter {
    func dateFormatter() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ID")
        formatter.dateFormat = "dd MMM yyyy - HH:mm"
        return formatter.string(from: date)
    }
}
