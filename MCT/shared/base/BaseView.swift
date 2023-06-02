//
//  BaseView.swift
//  MCT
//
//  Created by Daewi on 6/2/23.
//

import Foundation

@objc protocol BaseView {
    func startLoading()
    func finishLoading()
    func showErrorView(title: String,message: String)
    @objc optional func showSessionTimeout(title: String,message: String)
}
