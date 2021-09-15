//
//  ViewController.swift
//  iOS - BRQ Invest
//
//  Created by Ruy on 09/09/21.
//

import UIKit

class HomeViewController: UITableViewController {
    
    let cellHeightSpacing: CGFloat = 24
    
    var timer: Timer?
    
    let urlAPI = "https://api.hgbrasil.com/finance?&key=a6cb5965"
    
    var currencies = [Currency]()
    
    //MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Moedas"
        performRequest()
        
        timer = Timer.scheduledTimer(withTimeInterval: 216, repeats: true) { [weak self] _ in
            self?.performRequest()
        }
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
        cell.cellView.setBorderView()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cambioVC = storyboard?.instantiateViewController(identifier: "CambioViewController") as? CambioViewController {
            cambioVC.currencySelected = currencies[indexPath.section]
            navigationController?.pushViewController(cambioVC, animated: true)
        }
    }
    
    
    //MARK: - Creating a Cell
    
    func settingLabels(_ cell: CellData, for indexPath: IndexPath) {
        let currency = currencies[indexPath.section]
        print("\(currency.self)")
        switch currency.name {
        case "Dollar":
            cell.currencyISO.text = "USD"
        case "Euro":
            cell.currencyISO.text = "EUR"
        case "Pound Sterling":
            cell.currencyISO.text = "GBP"
        case "Argentine Peso":
            cell.currencyISO.text = "ARS"
        case "Canadian Dollar":
            cell.currencyISO.text = "CAD"
        case "Australian Dollar":
            cell.currencyISO.text = "AUD"
        case "Japanese Yen":
            cell.currencyISO.text = "JPY"
        case "Renminbi":
            cell.currencyISO.text = "CNY"
        case "Bitcoin":
            cell.currencyISO.text = "BTC"
        default:
            break
        }
        
        if currency.variation > 0.0 {
            cell.variationLabel.textColor = UIColor.systemGreen
        } else if currency.variation == 0.0 {
            cell.variationLabel.textColor = UIColor.white
        } else {
            cell.variationLabel.textColor = UIColor.systemRed
        }
        
        cell.variationLabel.text = currency.variationString
    }
    
    
    //MARK: - Requesting API
    
    @objc func performRequest() {
        guard let url = URL(string: urlAPI) else { return }
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
    
    @objc func parseJSON(_ financeData: Data){
        let decoder = JSONDecoder()
        print(financeData)
        do {
            let decodedData = try decoder.decode(FinanceData.self, from: financeData)
            print(decodedData)
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
