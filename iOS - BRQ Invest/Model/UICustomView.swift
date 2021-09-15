//
//  UICustomView.swift
//  iOS - BRQ Invest
//
//  Created by Ruy Miguel Penha Rodrigues on 15/09/21.
//

import UIKit

class UICustomView: UIView {

    func setBorderView() {
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.white.cgColor
    }

}
