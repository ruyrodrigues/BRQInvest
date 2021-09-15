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
    @IBOutlet weak var buyPriceLabel: UILabel!
    @IBOutlet weak var sellPriceLabel: UILabel!
    
    @IBOutlet weak var userBalanceLabel: UILabel!
    
    
    @IBOutlet weak var sellButton: UICustomButton!
    @IBOutlet weak var buyButton: UICustomButton!
    
    
    var currencySelected: Currency?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Câmbio"
        settingCustomBorders()
        settingLabels()
    }
    
    func settingLabels() {
        
        guard let currency = currencySelected else { return }
        
        currencyNameLabel.text = currency.name
        currencyVariationLabel.text = currency.variationString
        if currency.variation > 0 {
            currencyVariationLabel.textColor = UIColor.systemGreen
        } else if currency.variation < 0 {
            currencyVariationLabel.textColor = UIColor.systemRed
        } else {
            currencyVariationLabel.textColor = UIColor.white
        }
        
        buyPriceLabel.text = ("Compra: " + currency.buyString)
        sellPriceLabel.text = ("Venda: " + currency.sellString)
        
        userBalanceLabel.text = ("0 \(currency.name) em caixa")
    }
    
    func settingCustomBorders() {
        cambioView.setBorderView()
        sellButton.settingButton()
        buyButton.settingButton()
    }
}
