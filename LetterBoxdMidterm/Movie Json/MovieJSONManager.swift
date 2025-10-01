//
//  MovieJSONManager.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 20.09.25.
//

import Foundation
import UIKit

class MovieJSONManager {
    
    var allSections = [MovieSection]()
    
    func getData() {
        guard let fileURL = Bundle.main.url(forResource: "MovieFile", withExtension: "json") else {return }
        
        guard let data = try? Data(contentsOf: fileURL) else { return }
        
        do{
            allSections = try JSONDecoder().decode([MovieSection].self, from: data)
//            outerCollectionView.reloadData()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func getAllSections() -> Array<MovieSection> {
        return allSections
    }
    
    func getTheMovie(movieName : String) -> Movie {
        var selectedMovie : Movie = .init(name: "", cast: [], poster: "", duration: "", image: "", director: "", year: "", description: "")
        for section in allSections {
            if let movie = section.movies.first(where: { $0.name == movieName}) {
                selectedMovie =  movie
//                print("movie: \(selectedMovie)")
            }
        }
        return selectedMovie
    }
    
}
