//
//  MovieFile.swift
//  LetterBoxdMidterm
//
//  Created by Naila Amirova on 18.09.25.
//

import Foundation

struct MovieSection: Codable {
    let section: String
    let movies: [Movie]
}

struct Movie: Codable {
    var name : String
    var cast: [Cast]
    var poster: String
    var duration: String
    var image: String
    var director : String
    var year : String
    var description : String
}

struct Cast: Codable {
    var name: String
    var role: String
    var image: String
}
