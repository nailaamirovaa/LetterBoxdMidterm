//
//  FavoriteMovies+CoreDataProperties.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 29.09.25.
//
//

public import Foundation
public import CoreData


public typealias FavoriteMoviesCoreDataPropertiesSet = NSSet

extension FavoriteMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovies> {
        return NSFetchRequest<FavoriteMovies>(entityName: "FavoriteMovies")
    }

    @NSManaged public var movieTitle: String?
    @NSManaged public var user: User?

}

extension FavoriteMovies : Identifiable {

}
