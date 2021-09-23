//
//  CompraVendaViewController.swift
//  iOS - BRQ Invest
//
//  Created by Ruy Miguel Penha Rodrigues on 20/09/21.
//

import UIKit

class CompraVendaViewController: UIViewController {
    
    //Proprieties
    var message: String?
    
    
    //Outlets
    @IBOutlet weak var mensageTextLabel: UILabel!
    @IBOutlet weak var homeButton: UICustomButton!
    
    
    //ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let message = message else { return }
        mensageTextLabel.text = message
        homeButton.setButton()
    }
    
    
    //IBAction
    @IBAction func homeButtonPressed(_ sender: UICustomButton) {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
}
