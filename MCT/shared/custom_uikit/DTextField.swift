//
//  DTextField.swift
//  MCT
//
//  Created by Daewi on 6/1/23.
//

import Foundation
import UIKit

class DTextField: UITextField {
    
    var padding = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4);
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        createBorder()
    }
    
    func createBorder(){
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        
        self.addPadding(.left(16))
        
        //self.layer.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
        //UIColor(hexString:"#E0E0E0")self.layer.borderColor = UIColor(hexString: "993a3a")?.cgColor// UIColor(red: 119/255, green: 206/255, blue: 7/255, alpha: 1).cgColor
        //self.layer.borderWidth = 1.0
    }
    
}

