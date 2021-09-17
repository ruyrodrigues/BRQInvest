//
//  UICustomButton.swift
//  iOS - BRQ Invest
//
//  Created by Ruy Miguel Penha Rodrigues on 15/09/21.
//

import UIKit

class UICustomButton: UIButton {

    func settingButton() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
    }
    
    func disable() {
        self.isEnabled = false
        self.alpha = 0.45
    }
    
    func enable(){
        self.isEnabled = true
        self.alpha = 1
    }
    
}
