//
//  EditTransactionViewController.swift
//  MyMonee
//
//  Created by MacBook on 17/05/21.
//

import UIKit

class EditTransactionViewController: UIViewController, ButtonDelegate {
    
    @IBOutlet weak var headerComponent: HeaderWithBack!
    @IBOutlet weak var pemasukanChoice: UIButton!
    @IBOutlet weak var pengeluaranChoice: UIButton!
    @IBOutlet weak var deleteButtonComponent: ButtonView!
    @IBOutlet weak var saveButtonComponent: ButtonView!

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!

    var transactionType: TransactionType!
    //var selectedRow: Int? = 0
    var id = ""
    var service : TransactionServices = TransactionServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerComponent.delegate = self
        saveButtonComponent.delegate = self
        deleteButtonComponent.delegate = self
        loadAppearance()
        loadData()
        Helper.setTagButton(buttonView: saveButtonComponent, typeButton: .saveButton)
        Helper.setTagButton(buttonView: deleteButtonComponent, typeButton: .deleteButton)
        
        titleTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        amountTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func loadAppearance(){
        headerComponent.titleLabel.text = "Edit Penggunaan"
        
        saveButtonComponent.buttonView.layer.cornerRadius = 20
        saveButtonComponent.buttonView.setTitle("Perbaharui", for: .normal)
        saveButtonComponent.buttonView.setTitleColor(UIColor.white, for: .normal)
        
        deleteButtonComponent.buttonView.layer.cornerRadius = 20
        deleteButtonComponent.buttonView.backgroundColor = UIColor.white
        Helper.setDeleteButton(button: deleteButtonComponent.buttonView, title: "Hapus")
        
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
        }else{
            Helper.setButtonState(isEnabled: true, buttonView: saveButtonComponent.buttonView, button: saveButtonComponent)
        }
    }
    // MARK: -Button Action
    func buttonViewAction(sender: UIButton) {
        switch sender.tag {
            case ButtonTag.backButton.rawValue:
                self.navigationController?.popViewController(animated: true)
            case ButtonTag.saveButton.rawValue:
                self.saveData()
            case ButtonTag.deleteButton.rawValue:
                self.deleteData()
            default:
                print("default")
        }
    }
    
    func loadData(){
        self.service.getTransactionById(id: self.id) { (transaction) in
            DispatchQueue.main.async { [self] in
                dataTransaction = transaction
                titleTextField.text = dataTransaction.title
                amountTextField.text = String(dataTransaction.amount)
                switch dataTransaction.type {
                case TransactionType.debit.rawValue:
                    setDebitView()
                case TransactionType.credit.rawValue:
                    setCreditView()
                default:
                    ""
                }
            }
        }
    }
    
    func setDebitView(){
        transactionType = TransactionType.debit
        pemasukanChoice.isSelected = false
        pengeluaranChoice.isSelected = true
        Helper.setBorderButton(button: pengeluaranChoice)
        Helper.setButtonState(isEnabled: true, buttonView: saveButtonComponent.buttonView, button: saveButtonComponent)
    }
    
    func setCreditView(){
        transactionType = TransactionType.credit
        pemasukanChoice.isSelected = true
        pengeluaranChoice.isSelected = false
        Helper.setBorderButton(button: pemasukanChoice)
        Helper.setButtonState(isEnabled: true, buttonView: saveButtonComponent.buttonView, button: saveButtonComponent)
    }
    
    func saveData() {
        let currentDate = ""
        //let data = dataTransactions[selectedRow ?? 0]
        service.editTransaction(uploadDataModel: TransactionResponse(id: self.id, title: titleTextField.text!, amount: Double(amountTextField.text!) ?? 0.0, type: transactionType.rawValue, date: currentDate.dateFormatter)) {
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                Helper.showToast("Success Update Data")
            }
        }
        print("Success Edit To Array")
    }
    
    func deleteData(){
        service.deleteTransaction(id: self.id) {
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                print("Sucess")
            }
        }
        print("Success Delete From Array")
    }
    
    private func centerButtonImageAndTitle (button: UIButton) {
        let spacing: CGFloat = 6.0
        let imageSize = button.imageView!.frame.size
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0)
        let titleSize = button.titleLabel!.frame.size
        button.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
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
