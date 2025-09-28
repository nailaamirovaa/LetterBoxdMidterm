//
//  HomeController.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 16.09.25.
//

import UIKit

class HomeController: UIViewController  {
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var outerCollectionView: UICollectionView!
    
    var username = UserDefaults.standard.string(forKey: "username")
    var allMovies = [MovieSection]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        helloLabel.text = "Hello , \(username ?? "")"
        outerCollectionView.delegate = self
        outerCollectionView.dataSource = self
        getData()
        outerCollectionView.register(UINib(nibName: "HomeCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionCell")
    }
}

extension HomeController: UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionCell
        
        cell.configureOuterCell(label: allMovies[indexPath.row].section, movies: allMovies[indexPath.row].movies)
        
        let controller = storyboard?.instantiateViewController(identifier: "MovieController") as! MovieController
        cell.didSelectMovie = { movie in
            controller.getTheMovie(selectedMovie: movie)
            self.navigationController?.show(controller, sender: nil)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        .init(width: collectionView.bounds.width - 10 , height: collectionView.bounds.height/3 - 20 )
        
    }
}

extension HomeController {
    
    func getData() {
        guard let fileURL = Bundle.main.url(forResource: "MovieFile", withExtension: "json") else {return }
        
        guard let data = try? Data(contentsOf: fileURL) else { return }
        
        do{
            allMovies = try JSONDecoder().decode([MovieSection].self, from: data)
            outerCollectionView.reloadData()
        }catch{
            print(error.localizedDescription)
        }
    }
}
