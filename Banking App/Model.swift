//
//  File.swift
//  Banking App
//
//  Created by Jakub Gac on 18.07.2017.
//  Copyright © 2017 Jakub Gac. All rights reserved.
//

import Foundation

// transaction
enum TransactionCategory: String {
    case income
    case groceries
    case utilities
    case home
    case transport
    case fun
}

struct Transaction {
    let amount: Float // yes, I know, money should not be represented in float
    let description: String
    let date: Date
    let category: TransactionCategory
}

struct Account {
    let name: String
    let bank: String
    let number: String
    var transactions: [Transaction]
    
    var total: Float {
        return transactions.reduce(0.0, { $0 + $1.amount * ($1.category == .income ? 1 : -1) } )
    }
}

extension Transaction {
    var propertyListRepresentation: [String: AnyObject] {
        return [
            "amount": amount as AnyObject,
            "desciption": description as AnyObject,
            "date": date as AnyObject,
            "category": category as AnyObject
        ]
    }
    
    init(propertyList: [String: AnyObject]) {
        amount = propertyList["amount"] as! Float
        description = propertyList["desciption"] as! String
        date = propertyList["date"] as! Date
        category = TransactionCategory(rawValue: propertyList["category"] as! String)!
    }
}

extension Account {
    var propertyListRepresentation: [String: AnyObject] {
        return [
            "name": name as AnyObject,
            "bank": bank as AnyObject,
            "number": number as AnyObject,
            "transactions": transactions.map { $0.propertyListRepresentation } as AnyObject
        ]
    }
    
    init(propertyList: [String: AnyObject]) {
        name = propertyList["name"] as! String
        bank = propertyList["bank"] as! String
        number = propertyList["number"] as! String
        transactions = [Transaction.init(propertyList: propertyList["transactions"] as! [String: AnyObject])]
    }
}
