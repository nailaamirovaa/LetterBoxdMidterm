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
    @IBOutlet weak var trailerButton: UIButton!
    @IBOutlet weak var castCollection: UICollectionView!
    @IBOutlet weak var addToFavoriteButton: UIButton!
    @IBOutlet weak var showCastButton: UIButton!
    
    
    private var movie = Movie(name: "", cast: [], poster: "", duration: "", image: "", director: "", year: "", description: "" , trailer: "")
    
    var coreDataManager = CoreDataManager()
    
    var favoriteMovies = [FavoriteMovies]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(movie.name)
        print(movie.trailer)
        
        configureMovieUI(movie: movie)
        
        addtoFavoritesButtonConfigure()
        
        castCollection.delegate = self
        castCollection.dataSource = self
        
        trailerButton.layer.cornerRadius = 10

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
        let controller = storyboard?.instantiateViewController(identifier: "CastController") as! CastController
        controller.cast = movie.cast
        navigationController?.show(controller, sender: nil)
        
    }
    
    @IBAction func addToFavoriteButtonTapped(_ sender: UIButton) {
        
        let userId = UserDefaults.standard.string(forKey: "username")
        
        if UserDefaults.standard.bool(forKey: "\(movie.name)IsAdded") {
            UserDefaults.standard.set(false, forKey: "\(movie.name)IsAdded")
            coreDataManager.deleteMovie(title: movie.name, userId: userId ?? "")
            addtoFavoritesButtonConfigure()

            //coreDataManager.printFavorites(for: userId ?? "")
        } else {
            UserDefaults.standard.set(true, forKey: "\(movie.name)IsAdded")
            coreDataManager.fetchFavorites(for: userId ?? "")
            coreDataManager.saveFavoriteMovie(movieTitle: movie.name, userId: userId ?? "")
            addtoFavoritesButtonConfigure()
            //coreDataManager.printFavorites(for: userId ?? "")
        }
    }
    
    
    func getTheMovie(selectedMovie : Movie) {
        movie = selectedMovie
    }
    
    @IBAction func addToWatchlistButtonTapped(_ sender:
                                              UIButton) {
    }
    
    func addtoFavoritesButtonConfigure() {
        let isAddedTrue = coreDataManager.isAdded(movie: movie)
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
    
    @IBAction func watchTrailer(_ sender: UIButton) {
        guard let url = URL(string: movie.trailer) else { return  }
        UIApplication.shared.open(url)
        }
}


extension MovieController {
    
    func configureMovieUI(movie : Movie) {
        
        backgroundImage.image = UIImage(named: movie.image)
//        print(movie.poster)
        
        moviePosterImage.image = UIImage(named: movie.poster)
        movieNameLabel.text = "\(movie.name)   \(movie.year)"
        //       movieDurationLabel.text = movie.duration
        
        movieDirectorLabel.text = movie.director
        movieDescriptionLabel.text = movie.description
        
    }
}
