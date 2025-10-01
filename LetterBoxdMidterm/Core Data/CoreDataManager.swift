//
//  CoreDataManager.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 18.09.25.
//

import Foundation
import UIKit
import CoreData


struct UserStruct {
    
    var username : String
    var email : String
    var password : String
    var favMovies : [FavoriteMovies]

}


struct FavMoviesStruct {
    var movieTitle : String
    var userId : String
}


class CoreDataManager {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items = [User]()
    
    var userFavorites = [FavoriteMovies]()

    func fetchUserItems() {
        do {
            items = try context.fetch(User.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveUserItem(newUser: UserStruct) {
        let item = User(context: context)
        item.email = newUser.email
        item.username = newUser.username
        item.password = newUser.password
        
        do {
            fetchUserItems()
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteUserItem(index: Int) {
        context.delete(items[index])
        do {
            try context.save()
            fetchUserItems()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func printUserItems() {
        if items.isEmpty {
            print("No users found.")
        } else {
            for (index, user) in items.enumerated() {
                let username = user.username ?? "No username"
                let email = user.email ?? "No email"
                let password = user.password ?? "No password"
                print("\(index + 1). Username: \(username), Email: \(email), Password: \(password)")
            }
        }
    }
    
    func fetchFavorites(for userId: String) {
        let request: NSFetchRequest<FavoriteMovies> = FavoriteMovies.fetchRequest()
        request.predicate = NSPredicate(format: "user.username == %@", userId)
        
        do {
            userFavorites = try context.fetch(request)

        } catch {
            print("Failed to fetch favorites: \(error.localizedDescription)")
        }
    }
    
    func saveFavoriteMovie(movieTitle: String , userId: String) {
        
        let userRequest: NSFetchRequest<User> = User.fetchRequest()
        userRequest.predicate = NSPredicate(format: "username == %@", userId)
        
        do {
            if let user = try context.fetch(userRequest).first {
                let favorite = FavoriteMovies(context: context)
                favorite.movieTitle = movieTitle
                favorite.user = user
                
                fetchFavorites(for: user.username ?? "")
                //printFavorites(for: user.username ?? "")
                try context.save()
                //printFavorites(for: user.username ?? "")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteMovie(title : String , userId : String) {
        
        let movieRequest: NSFetchRequest<FavoriteMovies> = FavoriteMovies.fetchRequest()
        movieRequest.predicate = NSPredicate(format: "user.username == %@ AND movieTitle == %@", userId ,title)
        
        do {
            let favorites = try context.fetch(movieRequest)
            for fav in favorites {
                context.delete(fav)
            }
            try context.save()
            fetchFavorites(for: userId)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func printFavorites(for userId: String) {
//        let favorites = fetchFavorites(for: userId)
        
        if userFavorites.isEmpty {
            print("No favorites found for this user.")
        } else {
            print("🎬 Favorite Movies:")
            for (index, fav) in userFavorites.enumerated() {
                let title = fav.movieTitle ?? "Untitled"
                print("\(index + 1). \(title)")
            }
        }
    }
    
    func isAdded(movie: Movie) -> Bool {
        for favorite in userFavorites{
            if movie.name == favorite.
        }
    }
}
