//
//  DRadioButton.swift
//  MCT
//
//  Created by Daewi on 6/1/23.
//

import Foundation
import UIKit

class DRadioButton: UIButton {
    
    let normalImage = UIImage(named: "ic_radio_normal")! as UIImage
    let selectedImage = UIImage(named: "ic_radio_selected")! as UIImage
    
    var alternateButton:Array<DRadioButton>?
    
    override func awakeFromNib() {
    }
    
    func unselectAlternateButtons(){
        if alternateButton != nil {
            for aButton:DRadioButton in alternateButton! {
                aButton.isSelected = false
            }
            self.isSelected = true
        }else{
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton(){
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                // TODO: to save theme color and refersh ui
                self.setImage(resizeImage(image: selectedImage, targetHeight: 28), for: .normal)
                self.tintColor = UIColor.lightGray
            } else {
                self.setImage(resizeImage(image: normalImage, targetHeight: 28), for: .normal)
                self.tintColor = UIColor.lightGray
            }
        }
    }
    
    fileprivate func resizeImage(image: UIImage, targetHeight: CGFloat) -> UIImage {
        // Get current image size
        let size = image.size
        
        // Compute scaled, new size
        let heightRatio = targetHeight / size.height
        let newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Create new image
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Return new image
        return newImage!
    }

}
