//
//  ViewController.swift
//  iOS - BRQ Invest
//
//  Created by user on 09/09/21.
//

import UIKit

class ViewController: UITableViewController {
    
    let cellHeightSpacing: CGFloat = 24
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Moedas"
    }
    
    
    //MARK: - TableViewDelegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellHeightSpacing
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? Cell else { fatalError() }
        cell.moedaLabel.text = "USD"
        cell.variacaoLabel.text = "0,53%"
        setViewBorder(cell)
        return cell
    }
    
    
    func setViewBorder(_ cell: Cell) {
        cell.view.layer.masksToBounds = true
        cell.view.layer.borderWidth = 1
        cell.view.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        cell.view.layer.cornerRadius = 10
    }
}

