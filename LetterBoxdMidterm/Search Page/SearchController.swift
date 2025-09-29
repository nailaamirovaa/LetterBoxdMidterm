//
//  SearchController.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 21.09.25.
//

import UIKit

class SearchController: UIViewController, UISearchResultsUpdating {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var allSections: [MovieSection] = []
    private var allMovies: [Movie] = []
    private var selectedMovies: [Movie] = []
    private var isSearching = false
    
    private var collectionView : UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        getData()
        setUpSearchController()
        setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navBar = navigationController?.navigationBar {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .background
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBar.standardAppearance = appearance
            navBar.scrollEdgeAppearance = appearance
        }
        
        if let tabBar = tabBarController?.tabBar {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = .background
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
    }
    

    func getData() {
        guard let fileURL = Bundle.main.url(forResource: "MovieFile", withExtension: "json") else {return }
        
        guard let data = try? Data(contentsOf: fileURL) else { return }
        
        do {
            allSections = try JSONDecoder().decode([MovieSection].self, from: data)
//            outerCollectionView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
        
        for section in allSections {
            allMovies.append(contentsOf: section.movies)
        }
    }
    
    private func setUpSearchController() {
        searchController.searchBar.placeholder = "Search movies..."
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text , !query.isEmpty else {
            isSearching = false
            collectionView.reloadData()
            return
        }
        isSearching = true
        searchMovies(for: query)
    }
    
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let spacing : CGFloat = 5
        let itemWidth = view.bounds.width/3 - 10
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
                
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(UINib(nibName: "SearchCell", bundle: nil), forCellWithReuseIdentifier: "SearchCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func searchMovies(for query: String) {
        selectedMovies = allMovies.filter { $0.name.lowercased().contains(query.lowercased())}
        collectionView.reloadData()
        
    }
}

extension SearchController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? selectedMovies.count : allMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = isSearching ? selectedMovies[indexPath.row] : allMovies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.configureSearchCell(image: movie.poster, label: movie.name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isSearching {
            navigateToMovie(movie: allMovies[indexPath.row])
        } else {
            navigateToMovie(movie: selectedMovies[indexPath.row])
        }
    }
    
    func navigateToMovie(movie : Movie) {
        let controller = storyboard?.instantiateViewController(identifier: "MovieController") as! MovieController
        controller.getTheMovie(selectedMovie: movie)
        navigationController?.show(controller, sender: nil)
    }
}
