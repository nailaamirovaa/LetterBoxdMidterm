//
//  HomeCollectionCell.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 16.09.25.
//

import UIKit

class HomeCollectionCell: UICollectionViewCell {

    @IBOutlet private weak var cellLabel: UILabel!
    @IBOutlet private weak var innerCollectionView: UICollectionView!
    
    private var movies = [Movie]()
    
    var didSelectMovie : ((Movie) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        innerCollectionView.delegate = self
        innerCollectionView.dataSource = self
        
        innerCollectionView.register(UINib(nibName: "InnerHomwCollectionCell", bundle: nil), forCellWithReuseIdentifier: "InnerHomwCollectionCell")
    }
    
    func configureOuterCell(label : String , movies: [Movie]) {
        cellLabel.text = label
        self.movies = movies
    }
}


extension HomeCollectionCell: UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = innerCollectionView.dequeueReusableCell(withReuseIdentifier: "InnerHomwCollectionCell", for: indexPath) as! InnerHomwCollectionCell
        cell.configureInnerCell(image: movies[indexPath.row].poster)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: innerCollectionView.bounds.width/4 - 5 , height: innerCollectionView.bounds.height - 5 )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MovieController") as! MovieController
        let selectedMovie = movies[indexPath.row]
//        print(selectedMovie.name)
        controller.getTheMovie(selectedMovie: selectedMovie)
        didSelectMovie?(selectedMovie)
    }
}


