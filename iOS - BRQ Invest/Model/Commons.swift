//
//  Commons.swift
//  iOS - BRQ Invest
//
//  Created by Ruy Miguel Penha Rodrigues on 23/09/21.
//

import UIKit

extension UILabel {
    
    func setCollor(variation: Double) {
        if variation > 0 {
            self.textColor = UIColor.systemGreen
        } else if variation < 0 {
            self.textColor = UIColor.systemRed
        } else {
            self.textColor = UIColor.white
        }
    }
    
    
}
