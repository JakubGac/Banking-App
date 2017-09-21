//
//  NewTransactionViewController.swift
//  Banking App
//
//  Created by Jakub Gac on 20.07.2017.
//  Copyright © 2017 Jakub Gac. All rights reserved.
//

import UIKit

class NewTransactionViewController: UIViewController {

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet var ringViews: [UIView]!
    @IBOutlet var categoryButtons: [UIButton]!
    
    var selectedIndex = 0
    
    var amount: Float? {
        guard let text = amountTextField.text else {
            return nil
        }
        return Float(text)
    }
    
    var transactionDescription: String? {
        return descriptionTextField.text
    }
    
    var selectedCategory: TransactionCategory? {
        switch selectedIndex {
        case 0: return .income
        case 1: return .groceries
        case 2: return .utilities
        case 3: return .home
        case 4: return .transport
        case 5: return .fun
        default: return nil
        }
    }
    
    override func viewDidLoad() {
        resetRings()
    }
    
    @IBAction func selectCategory(_ sender: UIButton) {
        print("Przycisk wcisniety")
        resetRings()
        selectedIndex = categoryButtons.index(of: sender)!
        let selectedRingView = ringViews[selectedIndex]
        selectedRingView.layer.borderColor = UIColor.skyBlue.cgColor
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

extension NewTransactionViewController {
    func resetRings() {
        for ringView in ringViews {
            ringView.layer.borderColor = UIColor.clear.cgColor
        }
    }
}

extension TransactionCategory {
    struct Appearance {
        let color: UIColor
        let image: UIImage
    }
    
    var appearance: Appearance {
        switch self {
        case .income: return Appearance(color: .lightGrassGreen, image: #imageLiteral(resourceName: "income"))
        case .groceries: return Appearance(color: .seafoamBlue, image: #imageLiteral(resourceName: "groceries"))
        case .utilities: return Appearance(color: .liliac, image: #imageLiteral(resourceName: "utilities"))
        case .home: return Appearance(color: .sunflowerYellow, image: #imageLiteral(resourceName: "home"))
        case .transport: return Appearance(color: .peach, image: #imageLiteral(resourceName: "transport"))
        case .fun: return Appearance(color: .carnation, image: #imageLiteral(resourceName: "fun"))
        }
    }
}
