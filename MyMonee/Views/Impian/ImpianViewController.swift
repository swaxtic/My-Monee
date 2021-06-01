//
//  ImpianViewController.swift
//  MyMonee
//
//  Created by MacBook on 13/05/21.
//

import UIKit

class ImpianViewController: UIViewController, ButtonDelegate {

    @IBOutlet weak var headerComponent: HeaderView!
    @IBOutlet weak var tableImpianView: UITableView!
    @IBOutlet weak var emptyDataView: EmptyDataView!
    var selectedRow: Int? = 0
    var service : TransactionServices = TransactionServices()
    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.setHeaderWithoutGreeting(imageName: "add_24px", headerComponent: headerComponent, titleButton: "")
        Helper.registerTable(table: tableImpianView, dataSource: self, delegate: self, cellClass: ImpianTableViewCell.self)
        headerComponent.headerText.text = "Impian"
        Helper.setTagButton(buttonView: headerComponent.headerRightButton, typeButton: .addImpianButton)
        headerComponent.delegate = self
        
        Helper.setEmptyDataComponent(text: "Data Kamu Kosong, Yuk mulai buat Impian kamu!", emptyDataView: emptyDataView, titleButton: "Tambah Impian")
        Helper.setTagButton(buttonView: emptyDataView.buttonAdd, typeButton: .addImpianButton)
        emptyDataView.delegate = self
        
        setupAppearance()
        self.view.backgroundColor = UIColor(named: "Main Background Color")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableImpianView.reloadData()
        checkData()
    }
    
    func buttonViewAction(sender: UIButton) {
        print(sender.tag)
        switch sender.tag {
        case ButtonTag.addImpianButton.rawValue:
            let vc = AddImpianViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            "Default"
        }
    }
    
    func checkData(){
        if(dataImpian.count == 0){
            tableImpianView.isHidden = true
            emptyDataView.isHidden = false
        }else{
            emptyDataView.isHidden = true
            tableImpianView.isHidden = false
        }
    }
}

extension ImpianViewController: UITabBarDelegate, UITableViewDataSource, UITableViewDelegate, ButtonCellDelegate {
    
    func buttonCellDone(sender: UIButton) {
        let data = dataImpian[sender.tag]
        let date = ""
        let id = Helper.generateId()
        service.postTransaction(uploadDataModel: TransactionResponse(id: id, title: data.title, amount: data.targetMoney, type: TransactionType.debit.rawValue, date: date.dateFormatter)) {
            DispatchQueue.main.async {
                self.tabBarController?.navigationController?.popToViewController(HomeViewController(), animated: true)
                Helper.showToast("Success Add Data")
            }
        }
        dataImpian.remove(at: sender.tag)
        tableImpianView.reloadData()
        checkData()
    }
    
    func buttonCellDelete(sender: UIButton) {
        dataImpian.remove(at: sender.tag)
        tableImpianView.reloadData()
        checkData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataImpian.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ImpianTableViewCell.self), for: indexPath) as! ImpianTableViewCell
        let impian = dataImpian[indexPath.row]
        cell.buttonSelesai.tag = indexPath.row
        cell.buttonHapus.tag = indexPath.row
        cell.delegate = self
    
        cell.buttonSelesai.isEnabled = false
        if dataProfile.balance >= impian.targetMoney {
            cell.buttonSelesai.isEnabled = true
            cell.buttonSelesai.setImage(UIImage(named: "Done_Green"), for: .normal)
        }

        cell.impianTitleLable.text = impian.title
        cell.impianProgress.progress = Float(dataProfile.balance/impian.targetMoney)
        cell.impianBottomText.text = "\(dataProfile.balance.rupiahFormatter) / \(impian.targetMoney.rupiahFormatter)"
        return cell
    }
    
    func checkProgressData(){
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ImpianDetailViewController()
        vc.selectedRow = indexPath.row
        self.selectedRow = indexPath.row
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func setupAppearance() {
        tableImpianView.backgroundColor = UIColor.clear
        tableImpianView.tintColor = UIColor.clear
    }
}
