//
//  ImpianDetailViewController.swift
//  MyMonee
//
//  Created by MacBook on 15/05/21.
//

import UIKit

class TransactionDetailViewController: UIViewController, ButtonDelegate {
    
    @IBOutlet weak var detailDataView: UIView!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var backButtonView: ButtonView!
    
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var transactionTypeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var selectedRow: Int? = 0
    var id: String = ""
    var services: TransactionServices = TransactionServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.setHeaderWithoutGreeting(imageName: "Create_Icon", headerComponent: headerView, titleButton: "")
        Helper.roundCornerTop(radius: 24, uiView: detailDataView)
        
        Helper.setTagButton(buttonView: headerView.headerRightButton, typeButton: .editTransactionButton)

        Helper.setTagButton(buttonView: backButtonView, typeButton: .backButton)
                
        backButtonView.delegate = self
        headerView.delegate = self
        loadData()
        appearance()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    func buttonViewAction(sender: UIButton) {
        switch sender.tag {
            case ButtonTag.backButton.rawValue:
                    self.navigationController?.popViewController(animated: true)
            case ButtonTag.editTransactionButton.rawValue:
                let vc = EditTransactionViewController()
                vc.id = dataTransactions[selectedRow ?? 0].id
                //vc.selectedRow = selectedRow
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                print("default")
        }
    }
    
    func loadData(){
        loadingIndicator.startAnimating()
        let currentData = dataTransactions[selectedRow ?? 0]
        imageContainer.startShimmeringEffect()
        self.services.getTransactionById(id: currentData.id) { (transaction) in
            DispatchQueue.main.async { [self] in
                loadingIndicator.stopAnimating()
                imageContainer.stopShimmeringEffect()
                dataTransaction = transaction
                titleLabel.text = dataTransaction.title
                amountLabel.text = dataTransaction.amount.rupiahFormatter
                dateTimeLabel.text = dataTransaction.date
                idLabel.text = String(dataTransaction.id)
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
        imageContainer.backgroundColor = UIColor(named: "Red 20 percent")
        imageDetail.image = UIImage(named: "arrow_downward_24px")
        transactionTypeLabel.text = "Pengeluaran"
        amountLabel.textColor = UIColor(named: "Red")
    }
    
    func setCreditView(){
        imageContainer.backgroundColor = UIColor(named: "Green 20 percent")
        imageDetail.image = UIImage(named: "arrow_upward_24px")
        transactionTypeLabel.text = "Pemasukan"
        amountLabel.textColor = UIColor(named: "Green")
    }
        
    func appearance(){
        
        self.view.backgroundColor = UIColor(named: "Main Background Color")
        imageContainer.layer.cornerRadius = 4
        
        titleLabel.textColor = UIColor(named: "Dark Text")
        transactionTypeLabel.textColor = UIColor(named: "Grey Text")
        
        backButtonView.contentView.backgroundColor = UIColor.white
        backButtonView.contentView.layer.borderWidth = 3
        backButtonView.contentView.layer.borderColor = UIColor(named: "Main Blue Color")?.cgColor
        backButtonView.contentView.layer.cornerRadius = 20
        backButtonView.buttonView.setTitle("Kembali", for: .normal)
        
        backButtonView.buttonView.setTitleColor(UIColor.init(named: "Main Blue Color"), for: .normal)
    
    }

}
