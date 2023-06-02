//
//  TransactionHistoryCell.swift
//  MCT
//
//  Created by Daewi on 6/2/23.
//

import UIKit

class TransactionHistoryCell: UITableViewCell {

    @IBOutlet weak var tvSendDate: UILabel!
    @IBOutlet weak var tvAccount: UILabel!
    @IBOutlet weak var tvAmount: UILabel!
    @IBOutlet weak var tvStatus: UILabel!
    
    var transactionHistoryItem: TransactionHistoryItem? {
        didSet {
           showTransactionHistory()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func showTransactionHistory() {
        guard let transactionHistoryItem = transactionHistoryItem else { return }
        tvSendDate.text = transactionHistoryItem.date ?? ""
        tvAccount.text = transactionHistoryItem.account ?? ""
        tvAmount.text = transactionHistoryItem.amount ?? ""
        tvStatus.text = transactionHistoryItem.status ?? ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
