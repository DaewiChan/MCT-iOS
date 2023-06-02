//
//  HomePresenter.swift
//  MCT
//
//  Created by Daewi on 6/2/23.
//

import Foundation

protocol HomeView: BaseView {
    func showTransactionHistories(histories: [TransactionHistoryItem])
    func showAdminUserType()
    func showNormalUserType()
}

class HomePresenter: BasePresenter {
    
    private var view : HomeView?
    
    func attachView(view: HomeView) {
        self.view = view
    }
    
    func detachView() {
        view = nil
    }
    
    func getTransactionHistories() {
        let histories = getTransactionHistoriesData()
        self.view?.showTransactionHistories(histories: histories)
    }
    
    
    func checkUserType() {
        let userType = UserType(rawValue: PrefHelper.shared.getPrefValueString(PrefKey.USER_TYPE))
        switch userType {
        case .userLogin:
            self.view?.showNormalUserType()
        case .adminLogin:
            self.view?.showAdminUserType()
        default:
            self.view?.showNormalUserType()
        }
    }
}
