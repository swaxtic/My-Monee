//
//  EditImpianViewController.swift
//  MyMonee
//
//  Created by MacBook on 16/05/21.
//

import UIKit

class EditImpianViewController: UIViewController,ButtonDelegate {


    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var headerComponent: HeaderWithBack!
    @IBOutlet weak var saveButtonComponent: ButtonView!
    @IBOutlet weak var deleteButtonComponent: ButtonView!
    
    var selectedRow: Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.setTagButton(buttonView: headerComponent.backButton, typeButton: .backButton)
        headerComponent.delegate = self
        Helper.setTagButton(buttonView: saveButtonComponent, typeButton: .saveButton)
        saveButtonComponent.delegate = self
        Helper.setTagButton(buttonView: deleteButtonComponent, typeButton: .deleteButton)
        deleteButtonComponent.delegate = self
        
        titleTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        amountTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        loadAppearance()
        loadData()
    }
    
    private func loadAppearance(){
        headerComponent.titleLabel.text = "Ubah Impian"
        
        Helper.setButtonState(isEnabled: false, buttonView: saveButtonComponent.buttonView, button: saveButtonComponent)
        saveButtonComponent.buttonView.layer.cornerRadius = 20
        saveButtonComponent.buttonView.setTitle("Simpan", for: .normal)
        saveButtonComponent.buttonView.setTitleColor(UIColor.white, for: .normal)
        
        deleteButtonComponent.buttonView.layer.cornerRadius = 20
        deleteButtonComponent.buttonView.backgroundColor = UIColor.white
        Helper.setDeleteButton(button: deleteButtonComponent.buttonView, title: "Hapus")
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if titleTextField.text?.isEmpty ?? false || amountTextField.text?.isEmpty ?? false {
            Helper.setButtonState(isEnabled: false, buttonView: saveButtonComponent.buttonView, button: saveButtonComponent)
        }else {
            Helper.setButtonState(isEnabled: true, buttonView: saveButtonComponent.buttonView, button: saveButtonComponent)
        }
    }

    func buttonViewAction(sender: UIButton) {
        switch sender.tag {
        case ButtonTag.backButton.rawValue:
            self.navigationController?.popViewController(animated: true)
        case ButtonTag.saveButton.rawValue:
            saveData()
        case ButtonTag.deleteButton.rawValue:
            self.deleteData()
        default:
            print("default")
        }
    }
    
    func loadData(){
        let data = dataImpian[selectedRow ?? 0]
        titleTextField.text = data.title
        amountTextField.text = String(data.targetMoney)
    }
    
    func saveData() {
        dataImpian[selectedRow ?? 0] = Impian(title: titleTextField.text!, currentMoney: dataImpian[selectedRow ?? 0].currentMoney, targetMoney: Double(amountTextField.text!) ?? 0.0)
            
        self.navigationController?.popToRootViewController(animated: true)
        print("Success Edit To Array")
    }
    
    func deleteData(){
        dataImpian.remove(at: selectedRow ?? 0)
        self.navigationController?.popToRootViewController(animated: true)
        print("Success Delete From Array")
    }
}
