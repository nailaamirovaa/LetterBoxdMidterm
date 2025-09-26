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
    
    private var movie = Movie(name: "", cast: [], poster: "", duration: "", image: "", director: "", year: "", description: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImage.image = UIImage(named: "godfather_image")
        print(movie.poster)
        moviePosterImage.image = UIImage(named: movie.poster)
        movieNameLabel.text = "\(movie.name)   \(movie.year)"
//        movieDurationLabel.text = movie.duration
        movieDirectorLabel.text = movie.director
        movieDescriptionLabel.text = movie.description
        
        castCollection.delegate = self
        castCollection.dataSource = self
        
        addToWatchlistButton.layer.cornerRadius = 10
        rateButton.layer.cornerRadius = 10

        castCollection.register(UINib(nibName: "CastCell", bundle: nil), forCellWithReuseIdentifier: "CastCell")
        
        let headerNib = UINib(nibName: "CastCollectionHeader", bundle: nil)
        castCollection.register(headerNib,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "CastCollectionHeader")
        
    }
    
//    @IBAction func addToFavoriteButtonTapped(_ sender: UIButton) {
//    }
//    
    
    func getTheMovie(selectedMovie : Movie) {
        movie = selectedMovie
    }
    
    @IBAction func rateButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func addToWatchlistButtonTapped(_ sender: UIButton) {
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
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: "CastCollectionHeader",
                                                                         for: indexPath) as! CastCollectionHeader
            header.seeAllButton.addTarget(self, action: #selector(seeAllTapped), for: .touchUpInside)
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    @objc func seeAllTapped() {
//        let fullCastVC = FullCastViewController()
//        navigationController?.pushViewController(fullCastVC, animated: true)
    }
}
