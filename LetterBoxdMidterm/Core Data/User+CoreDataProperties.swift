//
//  User+CoreDataProperties.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 18.09.25.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?
    @NSManaged public var email: String?

}

extension User : Identifiable {

}
