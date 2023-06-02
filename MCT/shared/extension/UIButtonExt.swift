//
//  UIButtonExt.swift
//  MCT
//
//  Created by Daewi on 6/2/23.
//

import UIKit

// MARK: TableView Extension
extension UIButton {
    func roundButton() {
        self.layer.cornerRadius = 16.0
        self.layer.masksToBounds = true
    }
}
