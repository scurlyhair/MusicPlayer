//
//  Account+CoreDataProperties.swift
//  MusicPlayer
//
//  Created by scurlyhair on 2020/7/14.
//  Copyright © 2020 yunhui wu. All rights reserved.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var username: String
    @NSManaged public var token: String

}

// MARK: - Decodable Model

extension Account {
    struct DecodableModel: Decodable {
        var username: String
        var token: String
        
        func mapToAccount() -> Account {
            let account = Account()
            account.username = username
            account.token = token
            return account
        }
        
    }
}
