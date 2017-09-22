//
//  AccountDetailsViewController.swift
//  Banking App
//
//  Created by Jakub Gac on 20.07.2017.
//  Copyright © 2017 Jakub Gac. All rights reserved.
//

import UIKit

class AccountDetailsViewController: UIViewController {

    @IBAction func cancelTransactionCreation(segue: UIStoryboardSegue) {
        print("cancel")
    }
    
    @IBAction func saveTransaction(segue: UIStoryboardSegue) {
        print("save")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class TransactionCell: UITableViewCell {
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var model: Model? {
        didSet {
            guard let model = model else {
                return
            }
            circleView.backgroundColor = model.categoryColor
            categoryImageView.image = model.categoryImage
            descriptionLabel.text = model.description
            amountLabel.text = model.amount
            amountLabel.textColor = model.amountColor
            dateLabel.text = model.date
        }
    }
}

extension TransactionCell {
    struct Model {
        let categoryColor: UIColor
        let categoryImage: UIImage
        let description: String
        let date: String
        let amount: String
        let amountColor: UIColor
        
        init(transaction: Transaction) {
            categoryColor = transaction.category.appearance.color
            categoryImage = transaction.category.appearance.image
            description = transaction.description
            amount = transaction.amount.dollarsFormatting
            date = transaction.date.transactionFormatting
            amountColor = transaction.category == .income ? .darkLimeGreen : .slate
        }
    }
}
