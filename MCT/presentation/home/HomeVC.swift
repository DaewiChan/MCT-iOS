//
//  HomeVC.swift
//  MCT
//
//  Created by Daewi on 6/2/23.
//
import Foundation
import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var transactionHistoryTableView: UITableView!
    
    @IBOutlet weak var lblUserType: UILabel!
    @IBOutlet weak var cvTransactionHistory: DCardView!
    
    
    @IBOutlet weak var lblCredit: UILabel!
    @IBOutlet weak var walletBalanceLabel: UILabel!
    @IBOutlet weak var incomeAmountLabel: UILabel!
    @IBOutlet weak var outcomeAmountLabel: UILabel!
    
    var transactionHistories: [TransactionHistoryItem]?
    
    private let presenter = HomePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        initUI()
        loadData()
    }

    private func loadData() {
        presenter.checkUserType()
        presenter.getTransactionHistories()
    }
    
    private func initUI() {
        setupTransactionHistoryTableView()
    }
    
    private func setupTransactionHistoryTableView() {
        transactionHistoryTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        transactionHistoryTableView.separatorStyle = .none
        transactionHistoryTableView.estimatedRowHeight = 80.0
        transactionHistoryTableView.rowHeight = UITableView.automaticDimension
        transactionHistoryTableView.showsVerticalScrollIndicator = false
        transactionHistoryTableView.tableFooterView = UIView()
        transactionHistoryTableView.register(UINib(nibName: String(describing: TransactionHistoryCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TransactionHistoryCell.self))
        transactionHistoryTableView.delegate = self
        transactionHistoryTableView.dataSource = self
    }
    
    private func showUserInfo() {
        
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionHistories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionHistoryCell") as? TransactionHistoryCell {
            let transactionHistory = transactionHistories?[indexPath.row]
            cell.transactionHistoryItem = transactionHistory
            return cell
        }
        return UITableViewCell()
    }
    
}

extension HomeVC: HomeView {
    func startLoading() { }
    
    func finishLoading() { }
    
    func showErrorView(title: String, message: String) { }
    
    func showTransactionHistories(histories: [TransactionHistoryItem]) {
        self.transactionHistories = histories
        self.transactionHistoryTableView.reloadData()
    }
    
    func showNormalUserType() {
        lblCredit.text = "Account Credit Amount"
        lblUserType.text = "Hello, Sir"
        cvTransactionHistory.isHidden = false
    }
    
    func showAdminUserType() {
        lblCredit.text = "Admin Dashboard"
        lblUserType.text = "Admin"
        cvTransactionHistory.isHidden = true
    }
}
