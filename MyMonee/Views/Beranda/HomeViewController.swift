//
//  HomeViewController.swift
//  MyMonee
//
//  Created by MacBook on 13/05/21.
//

import UIKit

class HomeViewController: UIViewController, ButtonDelegate {
    
    @IBOutlet weak var historyComponent: UIView!
    @IBOutlet weak var cashFlowCollection: UICollectionView!
    @IBOutlet weak var historyTransactionTable: UITableView!
    @IBOutlet weak var headerComponent: HeaderView!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var emptyDataView: EmptyDataView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    var service: TransactionServices = TransactionServices()
    var selectedRow: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Helper.setHeaderWithGreeting(headerUsername: "Your Name", imageName: "add_24px", headerComponent: headerComponent, titleButton: "")
        Helper.registerTable(table: historyTransactionTable, dataSource: self, delegate: self, cellClass: HistoryTransactionTableViewCell.self)
        Helper.roundCornerTop(radius: 24, uiView: historyComponent)
        Helper.registerCollectionView(collectionView: cashFlowCollection, dataSource: self, delegate: self, cellClass: CashFlowCollectionViewCell.self)
        
        Helper.setTagButton(buttonView: headerComponent.headerRightButton, typeButton: .addTransactionButton)

        Helper.setTagButton(buttonView: emptyDataView.buttonAdd, typeButton: .addTransactionButton)
        Helper.setEmptyDataComponent(text: "Data Kamu Kosong, Yuk mulai buat Catatan kamu!", emptyDataView: emptyDataView, titleButton: "Tambah Penggunaan")
        
        emptyDataView.delegate = self
        headerComponent.delegate = self
        emptyDataView.isHidden = true
        loadData()
        loadDataCashFlow()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emptyDataView.isHidden = true
        loadDataCashFlow()
        loadData()
        historyTransactionTable.reloadData()
    }
    
    func checkData(){
        if(dataTransactions.isEmpty){
            historyTransactionTable.isHidden = true
            emptyDataView.isHidden = false
        }else{
            emptyDataView.isHidden = true
            historyTransactionTable.isHidden = false
        }
    }
    
    func loadData() {
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        self.service.getTransactionList{ (transactionList) in
            DispatchQueue.main.async { [self] in
                dataTransactions = transactionList
                //print(dataTransactionApi)
                historyTransactionTable.reloadData()
                loadDataCashFlow()
                loadingIndicator.stopAnimating()
                loadingIndicator.isHidden = true
                headerComponent.headerUserName.text = dataProfile.name
                headerComponent.headerUserName.stopShimmeringEffect()
                checkData()
            }
        }
    }
    // MARK: --BUTTON ACTION
    func buttonViewAction(sender: UIButton) {
        switch sender.tag {
        case ButtonTag.addTransactionButton.rawValue:
            let vc = AddTransactionViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("default")
        }
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
    func loadDataCashFlow() {
        var debit: Double = 0.0
        var credit: Double = 0.0
        for value in dataTransactions{
            switch value.type {
            case TransactionType.debit.rawValue:
                debit += value.amount
            case TransactionType.credit.rawValue:
                credit += value.amount
                break
            default:
                ""
            }
        }
        dataCashFlow[0].amount = credit
        dataCashFlow[1].amount = debit
        dataProfile.balance = dataCashFlow[0].amount - dataCashFlow[1].amount
        self.balance.text = dataProfile.balance.rupiahFormatter
        cashFlowCollection.reloadData()
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataCashFlow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CashFlowCollectionViewCell.self), for: indexPath) as! CashFlowCollectionViewCell
        let cashflow = dataCashFlow[indexPath.row]
        cell.title.text = cashflow.title
        cell.image.image = UIImage(named: cashflow.imageName)
        cell.amount.text = cashflow.amount.rupiahFormatter
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - (8), height: collectionView.frame.height)
    }
    
}

extension HomeViewController: UITabBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return dataTransactionHistory.count
        return dataTransactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HistoryTransactionTableViewCell.self), for: indexPath) as! HistoryTransactionTableViewCell
        
        //cell.showData(data: dataTransactionApi[indexPath.row])
        let data = dataTransactions[indexPath.row]
        cell.titleLabel.text = data.title
        cell.dateTimeLabel.text = data.date
        switch data.type {
        case TransactionType.credit.rawValue:
            cell.imageContainerCell.backgroundColor = UIColor(named: "Green 20 percent")
            cell.imageCell.image = UIImage(named: "arrow_upward_24px")
            cell.amountLabel.text = "+\(data.amount.rupiahFormatter)"
            cell.amountLabel.textColor = UIColor(named: "Green")
        case TransactionType.debit.rawValue:
            cell.imageContainerCell.backgroundColor = UIColor(named: "Red 20 percent")
            cell.imageCell.image = UIImage(named: "arrow_downward_24px")
            cell.amountLabel.text = "-\(data.amount.rupiahFormatter)"
            cell.amountLabel.textColor = UIColor(named: "Red")
        default:
            ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        let vc = TransactionDetailViewController()

        vc.selectedRow = indexPath.row
        
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        //self.present(vc, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension UIView {
 func startShimmeringEffect() {
    //self.layer.backgroundColor = UIColor.init(named: "Disabled Button")?.cgColor
    let light = UIColor.white.cgColor
    let alpha = UIColor(red: 206/255, green: 10/255, blue: 10/255, alpha: 0.7).cgColor
    let gradient = CAGradientLayer()
    gradient.frame = CGRect(x: -self.bounds.size.width, y: 0, width: 3 * self.bounds.size.width, height: self.bounds.size.height)
    gradient.colors = [light, alpha, light]
    gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradient.endPoint = CGPoint(x: 1.0,y: 0.525)
    gradient.locations = [0.35, 0.50, 0.65]
    self.layer.mask = gradient
    let animation = CABasicAnimation(keyPath: "locations")
    animation.fromValue = [0.0, 0.1, 0.2]
    animation.toValue = [0.8, 0.9,1.0]
    animation.duration = 1.5
    animation.repeatCount = HUGE
    gradient.add(animation, forKey: "shimmer")
    }
    func stopShimmeringEffect() {
        self.layer.mask = nil
    }
}
