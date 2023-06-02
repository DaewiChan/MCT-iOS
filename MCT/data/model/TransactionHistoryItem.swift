//
//  TransactionHistoryItem.swift
//  MCT
//
//  Created by Daewi on 6/2/23.
//

import Foundation

class TransactionHistoryItem {
    var date: String?
    var account: String?
    var amount: String?
    var status: String?
    
    init(date: String? = nil, account: String? = nil, amount: String? = nil, status: String? = nil) {
        self.date = date
        self.account = account
        self.amount = amount
        self.status = status
    }
}

func getTransactionHistoriesData() -> [TransactionHistoryItem] {
    var histories = [TransactionHistoryItem]()
    
    var history = TransactionHistoryItem(date: "20/05/2023 8:12AM",account: "01103563",amount: "S$ 30",status: "Paid")
    histories.append(history)
    
    history = TransactionHistoryItem(date: "20/05/2023 10:10AM",account: "02105533",amount: "S$ 45",status: "Paid")
    histories.append(history)
    
    history = TransactionHistoryItem(date: "23/05/2023 06:10PM",account: "02104566",amount: "S$ 250",status: "Paid")
    histories.append(history)
    
    history = TransactionHistoryItem(date: "26/05/2023 11:10AM",account: "02102588",amount: "S$ 399",status: "Paid")
    histories.append(history)
    
    return histories
}
