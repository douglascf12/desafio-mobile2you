//
//  Movie.swift
//  DesafioMobile2You
//
//  Created by Douglas Cardoso Ferreira on 01/04/21.
//

import Foundation

struct Movie: Codable {
    let backdrop_path: String
    let id: Int
    let original_title: String
    let release_date: String
    let popularity: Double
    let vote_count: Int
}
