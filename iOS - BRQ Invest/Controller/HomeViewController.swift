//
//  ViewController.swift
//  iOS - BRQ Invest
//
//  Created by Ruy on 09/09/21.
//

import UIKit

class HomeViewController: UITableViewController {
    
    let cellHeightSpacing: CGFloat = 24
    
    let urlAPI = "https://api.hgbrasil.com/finance"
    let keyAPI = "?key=a6cb5965"
    
    var currencies = [Currency]()
    
    
    //MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Moedas"
        performRequest(with: "\(urlAPI)\(keyAPI)")
    }
    
    
    //MARK: - TableViewDelegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return currencies.count
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellData else { fatalError() }
        
        settingLabels(cell, for: indexPath)
        setViewBorder(cell)
        
        return cell
    }
    
    
    //MARK: - Creating a Cell
    
    func settingLabels(_ cell: CellData, for indexPath: IndexPath) {
        let currency = currencies[indexPath.section]
        
        switch currency.name {
        case "Dollar":
            cell.moedaLabel.text = "USD"
        case "Euro":
            cell.moedaLabel.text = "EUR"
        case "Pound Sterling":
            cell.moedaLabel.text = "GBP"
        case "Argentine Peso":
            cell.moedaLabel.text = "ARS"
        case "Canadian Dollar":
            cell.moedaLabel.text = "CAD"
        case "Australian Dollar":
            cell.moedaLabel.text = "AUD"
        case "Japanese Yen":
            cell.moedaLabel.text = "JPY"
        case "Renminbi":
            cell.moedaLabel.text = "CNY"
        case "Bitcoin":
            cell.moedaLabel.text = "BTC"
        default:
            break
        }
        
        if currency.variation > 0.0 {
            cell.variacaoLabel.textColor = UIColor(red: 126.0, green: 211.0, blue: 33.0, alpha: 1.0)
        } else if currency.variation == 0.0 {
            cell.variacaoLabel.textColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 1.0)
        } else {
            cell.variacaoLabel.textColor = UIColor.systemRed
        }
        
        cell.variacaoLabel.text = String(currency.variation)
    }
    
    func setViewBorder(_ cell: CellData) {
        cell.view.layer.masksToBounds = true
        cell.view.layer.borderWidth = 1
        cell.view.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        cell.view.layer.cornerRadius = 15
    }
    
    
    //MARK: - Requesting API
    
    func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                guard let error = error else { return }
                print(error)
                return
            }
            
            if let safeData = data {
                self.parseJSON(safeData)
            }
        }
        task.resume()
    }
    
    func parseJSON(_ financeData: Data){
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(FinanceData.self, from: financeData)
            currencies = [
                decodedData.results.currencies.USD,
                decodedData.results.currencies.EUR,
                decodedData.results.currencies.ARS,
                decodedData.results.currencies.AUD,
                decodedData.results.currencies.BTC,
                decodedData.results.currencies.CAD,
                decodedData.results.currencies.CNY,
                decodedData.results.currencies.GBP,
                decodedData.results.currencies.JPY
                    ]
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print(error)
            return
        }
    }
    
    
}
