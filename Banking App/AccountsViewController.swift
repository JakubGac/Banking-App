//
//  AccountsViewController.swift
//  Banking App
//
//  Created by Jakub Gac on 20.07.2017.
//  Copyright © 2017 Jakub Gac. All rights reserved.
//

import UIKit

class AccountsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var stateController: StateController!
    
    var dataSource: AccountsDataSource!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource = AccountsDataSource(accounts: stateController.accounts)
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    @IBAction func cancelAccountCreation(segue: UIStoryboardSegue) {
        print("cancel")
    }
    
    @IBAction func saveAccount(segue: UIStoryboardSegue) {
        print("save")
    }
}

class AccountsDataSource: NSObject {
    var accounts: [Account]
    
    init(accounts: [Account]) {
        self.accounts = accounts
    }
}

extension AccountsDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as! AccountCell
        let index = indexPath.row
        let account = accounts[index]
        cell.model = AccountCell.Model(account: account, index: index)
        return cell
    }
}

class AccountCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var coloredView: UIView!
    
    var model: Model? {
        didSet {
            guard let model = model else {
                return
            }
            nameLabel.text = model.name
            totalLabel.text = model.total
            bankLabel.text = model.bank
            numberLabel.text = model.number
            coloredView.backgroundColor = model.color
        }
    }
}

extension AccountCell {
    struct Model {
        let name: String
        let total: String
        let bank: String
        let number: String
        let color: UIColor
        
        init(account: Account, index: Int) {
            name = account.name
            total = account.total.dollarsFormatting
            bank = account.bank
            number = account.number.accountNumberFormatting
            color = UIColor.color(for: index)
        }
    }
}

extension UIColor {
    class var lightGrassGreen: UIColor {
        return UIColor(red: 171.0 / 255.0, green: 236.0 / 255.0, blue: 104.0 / 255.0, alpha: 1.0)
    }
    
    class var skyBlue: UIColor {
        return UIColor(red: 84.0 / 255.0, green: 199.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0)
    }
    
    class var seafoamBlue: UIColor {
        return UIColor(red: 93.0 / 255.0, green: 220.0 / 255.0, blue: 191.0 / 255.0, alpha: 1.0)
    }
    
    class var liliac: UIColor {
        return UIColor(red: 201.0 / 255.0, green: 138.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }
    
    class var sunflowerYellow: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 205.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    class var carnation: UIColor {
        return UIColor(red: 253.0 / 255.0, green: 100.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0)
    }
    
    class var peach: UIColor {
        return UIColor(red: 253.0 / 255.0, green: 169.0 / 255.0, blue: 123.0 / 255.0, alpha: 1.0)
    }
    
    class var slate: UIColor {
        return UIColor(red: 80.0 / 255.0, green: 107.0 / 255.0, blue: 120.0 / 255.0, alpha: 1.0)
    }
    
    class var darkLimeGreen: UIColor {
        return UIColor(red: 111.0 / 255.0, green: 221.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    class func color(for index: Int) -> UIColor {
        switch index % 6 {
        case 0: return .lightGrassGreen
        case 1: return .seafoamBlue
        case 2: return .liliac
        case 3: return .sunflowerYellow
        case 4: return .peach
        default: return .carnation
        }
    }
}

extension Float {
    var dollarsFormatting: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        return formatter.string(from: NSNumber(value: self))!
    }
}

extension String {
    var accountNumberFormatting: String {
        var formattedString = " "
        for(index, character) in characters.enumerated() {
            if index % 4 < 3 || index == characters.count - 1 {
                formattedString.append(character)
            } else {
                formattedString.append("\(character)")
            }
        }
        return formattedString
    }
}

extension Date {
    var transactionFormatting: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}

