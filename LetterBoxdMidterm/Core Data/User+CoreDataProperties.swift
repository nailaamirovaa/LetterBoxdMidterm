//
//  User+CoreDataProperties.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 29.09.25.
//
//

public import Foundation
public import CoreData


public typealias UserCoreDataPropertiesSet = NSSet

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var favMovies: FavoriteMovies?

}

extension User : Identifiable {

}
