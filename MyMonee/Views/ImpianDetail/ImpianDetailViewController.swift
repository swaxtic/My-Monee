//
//  ImpianDetailViewController.swift
//  MyMonee
//
//  Created by MacBook on 16/05/21.
//

import UIKit

class ImpianDetailViewController: UIViewController,ButtonDelegate {

    @IBOutlet weak var buttonBackView: ButtonView!
    @IBOutlet weak var buttonKonfirmasiView: ButtonView!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var imageViewComponent: UIView!
    @IBOutlet weak var progressViewComponent: UIView!
    @IBOutlet weak var detailDataView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currentAmounLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var currentProgressLabel: UILabel!
    
    var selectedRow: Int? = 0
    var service : TransactionServices = TransactionServices()

    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.setHeaderWithoutGreeting(imageName: "Create_Icon", headerComponent: headerView, titleButton: "")
        
        Helper.setTagButton(buttonView: buttonBackView, typeButton: .backButton)
        buttonBackView.delegate = self
        
        Helper.setTagButton(buttonView: headerView.headerRightButton, typeButton: .editImpianButton)
        headerView.delegate = self
        
        Helper.setTagButton(buttonView: buttonKonfirmasiView, typeButton: .konfirmasiImpian)
        buttonKonfirmasiView.delegate = self
        
        setupAppearance()
        loadData()
    }
    
    func loadData() {
        let data = dataImpian[selectedRow ?? 0]
        let progressValue = Float(dataProfile.balance/data.targetMoney)
        titleLabel.text = data.title
        currentAmounLabel.text = dataProfile.balance.rupiahFormatter
        percentageLabel.text = String(progressValue * 100) + "%"
        currentProgressLabel.text = "\(dataProfile.balance.rupiahFormatter)) / \(data.targetMoney.rupiahFormatter)"
        progressView.setProgress(progressValue, animated: true)
    }
    
    func konfirmasiImpian(){
        let data = dataImpian[selectedRow ?? 0]
        let date = ""
        let id = Helper.generateId()
        service.postTransaction(uploadDataModel: TransactionResponse(id: id, title: data.title, amount: data.targetMoney, type: TransactionType.debit.rawValue, date: date.dateFormatter)) {
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                Helper.showToast("Success Add Data")
            }
        }
    }
    
    func setupAppearance(){
        Helper.roundCornerTop(radius: 24, uiView: detailDataView)
        self.view.backgroundColor = UIColor(named: "Main Background Color")
        
        currentAmounLabel.textColor = UIColor(named: "Blue Tab Bar Color")
        
        Helper.dropShadowEffect(uiView: progressViewComponent)
        progressViewComponent.layer.cornerRadius = 8
        
        Helper.dropShadowEffect(uiView: imageViewComponent)
        imageViewComponent.layer.cornerRadius = 4
        
        buttonBackView.contentView.backgroundColor = UIColor.white
        buttonBackView.contentView.layer.borderWidth = 3
        buttonBackView.contentView.layer.borderColor = UIColor(named: "Main Blue Color")?.cgColor
        buttonBackView.contentView.layer.cornerRadius = 20
        buttonBackView.buttonView.setTitle("Kembali", for: .normal)
        
        buttonBackView.buttonView.setTitleColor(UIColor.init(named: "Main Blue Color"), for: .normal)
        
        if !(dataProfile.balance >= dataImpian[selectedRow ?? 0].targetMoney) {
            Helper.setButtonState(isEnabled: false, buttonView: buttonKonfirmasiView.contentView, button: buttonKonfirmasiView.buttonView)
        }else{
            Helper.setButtonState(isEnabled: true, buttonView: buttonKonfirmasiView.contentView, button: buttonKonfirmasiView.buttonView)
        }
        buttonKonfirmasiView.contentView.layer.cornerRadius = 20
        buttonKonfirmasiView.buttonView.setTitle("Konfirmasi Tercapai", for: .normal)
        buttonKonfirmasiView.buttonView.setTitleColor(UIColor.white, for: .normal)
        
    }
    
    // MARK: -- Button Action
    func buttonViewAction(sender: UIButton) {
        switch sender.tag {
        case ButtonTag.backButton.rawValue:
            self.navigationController?.popViewController(animated: true)
        case ButtonTag.editImpianButton.rawValue:
            let vc = EditImpianViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.selectedRow = self.selectedRow
            self.navigationController?.pushViewController(vc, animated: true)
        case ButtonTag.konfirmasiImpian.rawValue:
            self.konfirmasiImpian()
        default:
            "Default"
        }
    }
    
}
