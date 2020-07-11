//
//  User+CoreDataProperties.swift
//  MusicPlayer
//
//  Created by yunhui wu on 2020/7/9.
//  Copyright © 2020 yunhui wu. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var age: Int16

}

// MARK: - Decodable Model

extension User {
    struct DecodableModel: Decodable {
        var age: Int16
        
        func mapToUser() -> User {
            let user = User()
            user.age = age
            return user
        }
        
    }
}
