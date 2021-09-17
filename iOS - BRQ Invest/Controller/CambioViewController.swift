//
//  CambioViewController.swift
//  iOS - BRQ Invest
//
//  Created by Ruy on 13/09/21.
//

import UIKit

class CambioViewController: UIViewController, UITextFieldDelegate {
    
    // IBOutlets
    @IBOutlet var cambioView: UICustomView!
    
    @IBOutlet var currencyNameLabel: UILabel!
    @IBOutlet var currencyVariationLabel: UILabel!
    @IBOutlet weak var buyPriceLabel: UILabel!
    @IBOutlet weak var sellPriceLabel: UILabel!
    
    @IBOutlet weak var userCurrencyBalanceLabel: UILabel!
    @IBOutlet weak var userBalanceLabel: UILabel!
    
    @IBOutlet weak var sellButton: UICustomButton!
    @IBOutlet weak var buyButton: UICustomButton!
    
    @IBOutlet weak var AmountTextField: UITextField!
    
    
    // Proprieties
    var currencySelected: Currency?
    var currencyISO = String()
    var user: User?
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        AmountTextField.delegate = self
        title = "Câmbio"
        
        setCustomBorders()
        setLabels()
        setTextField()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - Settings
    func setTextField() {
        AmountTextField.attributedPlaceholder =
            NSAttributedString(string: "Quantidade", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    func setLabels() {
        guard let currency = currencySelected else { return }
        guard let user = user else { return }
        guard let userCurrencyAmount = user.userWallet[currencyISO] else { return }
        
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
        
        userCurrencyBalanceLabel.text = ("\(userCurrencyAmount) \(currencyISO) em caixa")
        userBalanceLabel.text = ("Saldo disponível: \(user.balanceLabel)")
        
        checkButtonDisponility(buyButton, user, currency, iso: currencyISO)
        checkButtonDisponility(sellButton, user, currency, iso: currencyISO)
        
        AmountTextField.text = ""
    }
    
    func setCustomBorders() {
        cambioView.setBorderView()
        sellButton.settingButton()
        buyButton.settingButton()
    }
    
    
    func checkButtonDisponility(_ button: UICustomButton, _ user: User, _ currency: Currency, iso: String) {
        guard let currencyBuyPrice = currency.buy else { return }
        guard let currencyAmountInWallet = user.userWallet[iso] else { return }
        guard let stringInputAmount = AmountTextField.text else { return }
        
        var totalPrice = Double()
        var userInput = Int()
        
        if let intInputAmount = Int(stringInputAmount) {
            userInput = intInputAmount
            totalPrice = currencyBuyPrice * Double(intInputAmount)
        }
        
        if button.tag == 1 {
            // buy button
            if (user.balance < currencyBuyPrice || user.balance < totalPrice) {
                button.disable()
            } else {
                button.enable()
            }
        } else {
            // sell button
            if (userInput > currencyAmountInWallet || currency.sell == nil || currencyAmountInWallet == 0) {
                button.disable()
            } else {
                button.enable()
            }
        }
        
        if (stringInputAmount.isEmpty || userInput == 0) {
            button.disable()
        }
    }

    //MARK: TextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let currency = currencySelected else { return }
        guard let user = user else { return }
        
        checkButtonDisponility(buyButton, user, currency, iso: currencyISO)
        checkButtonDisponility(sellButton, user, currency, iso: currencyISO)
        
    }
    
    // @IBAction
    @IBAction func ButtonPressed(_ sender: UICustomButton) {
        guard let user = user else { return }
        guard let currency = currencySelected else { return }
        guard let stringInputAmount = AmountTextField.text else { return }
        guard let intInputAmount = Int(stringInputAmount) else { return }
        
        if sender.tag == 0 {
            //sell button
            user.sell(quantity: intInputAmount, currencyISO, currency)
        } else {
            //buy button
            user.buy(quantity: intInputAmount, currencyISO, currency)
        }
        
        setLabels()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
