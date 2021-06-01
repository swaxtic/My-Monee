//
//  AddImpianViewController.swift
//  MyMonee
//
//  Created by MacBook on 16/05/21.
//

import UIKit

class AddImpianViewController: UIViewController, ButtonDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var headerComponent: HeaderWithBack!
    @IBOutlet weak var saveButtonComponent: ButtonView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.setTagButton(buttonView: headerComponent.backButton, typeButton: .backButton)
        headerComponent.delegate = self
        Helper.setTagButton(buttonView: saveButtonComponent, typeButton: .saveButton)
        saveButtonComponent.delegate = self
        
        titleTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        amountTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        loadAppearance()
    }
    
    private func loadAppearance(){
        headerComponent.titleLabel.text = "Tambah Impian"
        
        Helper.setButtonState(isEnabled: false, buttonView: saveButtonComponent.buttonView, button: saveButtonComponent)
        saveButtonComponent.buttonView.layer.cornerRadius = 20
        saveButtonComponent.buttonView.setTitle("Simpan", for: .normal)
        saveButtonComponent.buttonView.setTitleColor(UIColor.white, for: .normal)
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
        default:
            print("default")
        }
    }
    
    func saveData() {
        dataImpian.append(Impian(title: titleTextField.text!, currentMoney: 0.0, targetMoney: Double(amountTextField.text!) ?? 0.0))
        self.navigationController?.popToRootViewController(animated: true)
        print("Success Add To Array")
    }

}
