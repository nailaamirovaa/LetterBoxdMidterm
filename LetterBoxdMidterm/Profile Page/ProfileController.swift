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
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var profileDetailsLabel: UILabel!
    @IBOutlet weak var collectionLabel: UILabel!
    
    var userManager = CoreDataManager()
    var jsonManager = MovieJSONManager()
    
    var username = UserDefaults.standard.string(forKey: "username")
    
    override func viewDidLoad() {
        super.viewDidLoad()


        collectionLabel.text = "\(username ?? "")'s Favorite Movies"
        
        signOutButton.layer.cornerRadius = 15
        profileImage.image = UIImage(named: "godfather_image")
        
        jsonManager.getData()
        userManager.fetchUserItems()
        userManager.fetchFavorites(for: username ?? "")
        
        updateFavoriteCountLabel(userManager.userFavorites.count)
        
        if let user = userManager.items.first(where: { $0.username == username}) {
            emailLabel.text = "Email: \(user.email!)"
            passwordLabel.text = "Password: \(user.password!)"
        }
        favoriteMoviesCollection.delegate = self
        favoriteMoviesCollection.dataSource = self
        
        favoriteMoviesCollection.register(UINib(nibName: "ProfileCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ProfileCollectionCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteMoviesCollection.reloadData()
        userManager.fetchFavorites(for: username ?? "")
        updateFavoriteCountLabel(userManager.userFavorites.count)
//        userManager.printFavorites(for: username ?? "")
//        print(userManager.userFavorites.count)
    }
    

    @IBAction func signOutButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let delegate = windowScene.delegate as? SceneDelegate {
                delegate.navToLogin()
            }
        }
    }
    
    func getTheMoviePoster(movieTitle : String) -> String{
        let movie = jsonManager.getTheMovie(movieName: movieTitle)
        return movie.poster
    }
    
    func updateFavoriteCountLabel(_ count: Int) {
        let numberString = "\(count) \n"
        let textString = " favorite movies"
        
        let numberAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.button,
            .font: UIFont.boldSystemFont(ofSize: 23)
        ]
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        
        let attributedText = NSMutableAttributedString(string: numberString, attributes: numberAttributes)
        attributedText.append(NSAttributedString(string: textString, attributes: textAttributes))
        
       
        favoriteMoviesCountLabel.attributedText = attributedText
    }
}


extension ProfileController: UICollectionViewDataSource, UICollectionViewDelegate ,
UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userManager.userFavorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionCell", for: indexPath) as! ProfileCollectionCell
        let poster = getTheMoviePoster(movieTitle: userManager.userFavorites[indexPath.row].movieTitle ?? "")
        cell.configureCell(image: poster)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width/4 - 10 , height: collectionView.bounds.height - 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(identifier: "MovieController") as! MovieController
        let movie = jsonManager.getTheMovie(movieName: userManager.userFavorites[indexPath.row].movieTitle ?? "")
        controller.getTheMovie(selectedMovie: movie)
        navigationController?.show(controller, sender: nil)
    }
}
