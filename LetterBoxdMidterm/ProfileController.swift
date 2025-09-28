//
//  ProfileController.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 19.09.25.
//

import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var favoriteMoviesCountLabel: UILabel!
    @IBOutlet weak var favoriteMoviesCollection: UICollectionView!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    
    var userManager = CoreDataManager()
    var username = UserDefaults.standard.string(forKey: "username")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signOutButton.layer.cornerRadius = 15
        profileImage.image = .howToTrainYourDragon
        
        userManager.fetchUserItems()
        if let user = userManager.items.first(where: { $0.username == username}) {
            usernameLabel.text = user.username
            emailLabel.text = user.email
            passwordLabel.text = user.password
        }
        favoriteMoviesCollection.delegate = self
        favoriteMoviesCollection.dataSource = self
        
        favoriteMoviesCollection.register(UINib(nibName: "ProfileCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ProfileCollectionCell")
       
//        view.backgroundColor = .background
    }
    

    @IBAction func signOutButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let delegate = windowScene.delegate as? SceneDelegate {
                delegate.navToLogin()
            }
        }
    }
}


extension ProfileController: UICollectionViewDataSource, UICollectionViewDelegate ,
UICollectionViewDelegateFlowLayout {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return isSearching ? selectedMovies.count : allMovies.count
        3
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let movie = isSearching ? selectedMovies[indexPath.row] : allMovies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionCell", for: indexPath) as! ProfileCollectionCell
//        cell.configureSearchCell(image: movie.poster, label: movie.name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width/4 - 10 , height: collectionView.bounds.height - 30)
    }
}
