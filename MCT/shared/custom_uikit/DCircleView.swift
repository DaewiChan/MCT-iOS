//
//  DCircleView.swift
//  MCT
//
//  Created by Daewi on 6/1/23.
//

import Foundation
import UIKit

class TCircleView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    override func layoutSubviews() {
       super.layoutSubviews()
   }
}
