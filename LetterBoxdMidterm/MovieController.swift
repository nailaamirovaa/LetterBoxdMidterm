//
//  MovieController.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 19.09.25.
//

import UIKit

class MovieController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
//    @IBOutlet weak var movieDurationLabel: UILabel!
    @IBOutlet weak var movieDirectorLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var addToWatchlistButton: UIButton!
    @IBOutlet weak var castCollection: UICollectionView!
    @IBOutlet weak var addToFavoriteButton: UIButton!
    @IBOutlet weak var showCastButton: UIButton!
    
    
    private var movie = Movie(name: "", cast: [], poster: "", duration: "", image: "", director: "", year: "", description: "")
    
    var coreDataManager = CoreDataManager()
    
    var favoriteMovies = [FavoriteMovies]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(movie.name)
        
        configureMovieUI(movie: movie)
        
        addtoFavoritesButtonConfigure()
        
        castCollection.delegate = self
        castCollection.dataSource = self
        
        addToWatchlistButton.layer.cornerRadius = 10
        rateButton.layer.cornerRadius = 10

        castCollection.register(UINib(nibName: "CastCell", bundle: nil), forCellWithReuseIdentifier: "CastCell")
        
//        let headerNib = UINib(nibName: "CastCollectionHeader", bundle: nil)
//        castCollection.register(headerNib,
//                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//                                withReuseIdentifier: "CastCollectionHeader")
        
        let userId = UserDefaults.standard.string(forKey: "username")
        coreDataManager.fetchFavorites(for: userId ?? "")
        favoriteMovies = coreDataManager.userFavorites
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureMovieUI(movie: movie)
        castCollection.reloadData()
        addtoFavoritesButtonConfigure()
    }
    
    
    @IBAction func showCastButtonTapped(_ sender: UIButton) {
//        let con
    }
    
    @IBAction func addToFavoriteButtonTapped(_ sender: UIButton) {
        
        let userId = UserDefaults.standard.string(forKey: "username")
        
        if UserDefaults.standard.bool(forKey: "\(movie.name)IsAdded") {
            UserDefaults.standard.set(false, forKey: "\(movie.name)IsAdded")
            coreDataManager.deleteMovie(title: movie.name, userId: userId ?? "")
            addtoFavoritesButtonConfigure()
//            coreDataManager.printFavorites(for: userId ?? "")
        } else {
            UserDefaults.standard.set(true, forKey: "\(movie.name)IsAdded")
            coreDataManager.saveFavoriteMovie(movieTitle: movie.name, userId: userId ?? "")
            coreDataManager.fetchFavorites(for: userId ?? "")
            addtoFavoritesButtonConfigure()
//            coreDataManager.printFavorites(for: userId ?? "")
        }
    }
    
    
    func getTheMovie(selectedMovie : Movie) {
        movie = selectedMovie
    }
    
    @IBAction func rateButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func addToWatchlistButtonTapped(_ sender:
                                              UIButton) {
    }
    
    func addtoFavoritesButtonConfigure() {
        let isAddedTrue = UserDefaults.standard.bool(forKey: "\(movie.name)IsAdded")
        if isAddedTrue {
            addToFavoriteButton.setImage(UIImage(systemName: "heart.fill" ), for: .normal)
            addToFavoriteButton.tintColor = .red
        } else {
            addToFavoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            addToFavoriteButton.tintColor = .red
        }
    }
}


extension MovieController: UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movie.cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as! CastCell
        cell.configureCastCell(image: movie.cast[indexPath.row].image, name: movie.cast[indexPath.row].name, role: movie.cast[indexPath.row].role)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        .init(width: collectionView.bounds.width/3 - 10 , height: collectionView.bounds.height-40 )
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedCategory = menu[indexPath.row]
//        let controller = storyboard?.instantiateViewController(identifier: "CategoryController") as! CategoryController
//        controller.category = selectedCategory
//        navigationController?.show(controller, sender: nil)
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        viewForSupplementaryElementOfKind kind: String,
//                        at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionView.elementKindSectionHeader {
//            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
//                                                                         withReuseIdentifier: "CastCollectionHeader",
//                                                                         for: indexPath) as! CastCollectionHeader
//            header.seeAllButton.addTarget(self, action: #selector(seeAllTapped), for: .touchUpInside)
//            return header
//        }
//        return UICollectionReusableView()
//    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 40)
//    }
    
    @objc func seeAllTapped() {
//        let fullCastVC = FullCastViewController()
//        navigationController?.pushViewController(fullCastVC, animated: true)
    }
}


extension MovieController {
    
    func configureMovieUI(movie : Movie) {
        
        backgroundImage.image = UIImage(named: "godfather_image")
//        print(movie.poster)
        
        moviePosterImage.image = UIImage(named: movie.poster)
        movieNameLabel.text = "\(movie.name)   \(movie.year)"
        //       movieDurationLabel.text = movie.duration
        
        movieDirectorLabel.text = movie.director
        movieDescriptionLabel.text = movie.description
        
    }
}
