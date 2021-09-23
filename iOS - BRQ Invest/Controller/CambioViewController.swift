//
//  CambioViewController.swift
//  iOS - BRQ Invest
//
//  Created by Ruy on 13/09/21.
//

import UIKit

class CambioViewController: UIViewController {
    
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
    
    @IBOutlet weak var amountTextField: UITextField!
    
    
    // Proprieties
    var currencySelected: Currency?
    var currencyISO = String()
    var user: User?
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        amountTextField.delegate = self
        title = "Câmbio"
        
        setCustomBorders()
        setLabels()
        setTextField()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - Settings
    func setTextField() {
        amountTextField.attributedPlaceholder =
            NSAttributedString(string: "Quantidade", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    func setLabels() {
        guard let currency = currencySelected,
              let user = user,
              let userCurrencyAmount = user.userWallet[currencyISO] else { return }
        
        currencyNameLabel.text = "\(currencyISO) - \(currency.name)"
        
        currencyVariationLabel.setCollor(variation: currency.variation)
        currencyVariationLabel.text = currency.variationString
        
        buyPriceLabel.text = ("Compra: " + currency.buyString)
        sellPriceLabel.text = ("Venda: " + currency.sellString)
        
        userCurrencyBalanceLabel.text = ("\(userCurrencyAmount) \(currencyISO) em caixa")
        userBalanceLabel.text = ("Saldo disponível: \(user.balanceLabel)")
        
        checkButtonDisponility(buyButton, user, currency, iso: currencyISO)
        checkButtonDisponility(sellButton, user, currency, iso: currencyISO)
        
        amountTextField.text = ""
    }
    
    func setCustomBorders() {
        cambioView.setBorderView()
        sellButton.setButton()
        buyButton.setButton()
    }
    
    
    func checkButtonDisponility(_ button: UICustomButton, _ user: User, _ currency: Currency, iso: String) {
        guard let currencyBuyPrice = currency.buy,
              let currencyAmountInWallet = user.userWallet[iso],
              let stringInputAmount = amountTextField.text else { return }
        
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
    
    // @IBAction
    @IBAction func ButtonPressed(_ sender: UICustomButton) {
        guard let user = user,
              let currency = currencySelected,
              let stringInputAmount = amountTextField.text,
              let intInputAmount = Int(stringInputAmount),
              let storyboard = storyboard,
              let CVVC = storyboard.instantiateViewController(identifier: "CompraVendaViewController") as? CompraVendaViewController,
              let navigationController = navigationController else { return }
        
        var buttonAction: String
        
        if sender.tag == 0 {
            //sell button
            buttonAction = "vender"
            user.sell(quantity: intInputAmount, currencyISO, currency)
        } else {
            //buy button
            buttonAction = "comprar"
            user.buy(quantity: intInputAmount, currencyISO, currency)
        }
        CVVC.message = createMessage(action: buttonAction, quantity: intInputAmount)
        CVVC.title = buttonAction.capitalized
        navigationController.pushViewController(CVVC, animated: true)
    }
    
    func createMessage(action: String, quantity: Int) -> String {
        guard let user = user,
              let currency = currencySelected else { return ""}
        return "Parabéns! Você acabou de \(action) \(quantity) \(currencyISO) - \(currency.name), totalizando \(user.balanceLabel)"
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        setLabels()
    }
    
}


extension CambioViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let currency = currencySelected,
              let user = user else { return }
        
        checkButtonDisponility(buyButton, user, currency, iso: currencyISO)
        checkButtonDisponility(sellButton, user, currency, iso: currencyISO)
        
    }
}
