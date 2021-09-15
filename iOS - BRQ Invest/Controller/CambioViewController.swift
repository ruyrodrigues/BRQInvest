//
//  CambioViewController.swift
//  iOS - BRQ Invest
//
//  Created by Ruy on 13/09/21.
//

import UIKit

class CambioViewController: UIViewController {
    
    //IBOutlets
    
    @IBOutlet var cambioView: UICustomView!
    @IBOutlet var currencyNameLabel: UILabel!
    @IBOutlet var currencyVariationLabel: UILabel!
    
    var currencySelected: Currency?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Câmbio"
        cambioView.setBorderView()
        currencyNameLabel.text = currencySelected?.name
    }
    
}
