//
//  ModelController.swift
//  Banking App
//
//  Created by Jakub Gac on 19.07.2017.
//  Copyright © 2017 Jakub Gac. All rights reserved.
//

import Foundation

class StorageController {
    // document directory
    fileprivate let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    // url to file with my data
    fileprivate var accountsFileURL: URL {
        return documentsDirectoryURL.appendingPathComponent("Accounts").appendingPathExtension("propertyList")
    }
    
    func save(accounts: [Account]) {
        let accountsPropertList = accounts.map { $0.propertyListRepresentation } as NSArray
        accountsPropertList.write(to: accountsFileURL, atomically: true)
    }
    
    func fetchAccounts() -> [Account] {
        guard let accountPropertyList = NSArray(contentsOf: accountsFileURL) as? [[String: AnyObject]] else {
            return []
        }
        if let tmp = accountPropertyList.first {
            return [Account.init(propertyList: tmp)]
        }
        return []
    }
}

// this class keeps the shared state of the app by keeping the list of accounts inside an array
class StateController {
    fileprivate let storageController: StorageController
    fileprivate(set) var accounts: [Account]
    
    init(storageController: StorageController) {
        self.storageController = storageController
        self.accounts = storageController.fetchAccounts()
    }
    
    func add(account: Account) {
        accounts.append(account)
        storageController.save(accounts: accounts)
    }
    
    func update(account: Account) {
        for(index, storedAccount) in accounts.enumerated() {
            guard storedAccount.number == account.number else {
                continue
            }
            accounts[index] = account
            storageController.save(accounts: accounts)
            break
        }
    }
}
