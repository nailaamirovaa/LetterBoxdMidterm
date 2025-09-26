//
//  CoreDataManager.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 18.09.25.
//

import Foundation
import UIKit


struct UserStruct {
    
    var username : String
    var email : String
    var password : String
//    var watchlist
}

class CoreDataManager {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items = [User]()

    func fetchItems() {
        do {
            items = try context.fetch(User.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveItem(newUser: UserStruct) {
        let item = User(context: context)
        item.email = newUser.email
        item.username = newUser.username
        item.password = newUser.password
        
        do {
            try context.save()
            fetchItems()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteItem(index: Int) {
        context.delete(items[index])
        do {
            try context.save()
            fetchItems()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func printItems() {
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
}
