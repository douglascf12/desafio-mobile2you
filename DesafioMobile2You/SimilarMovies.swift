//
//  MoviesSimilar.swift
//  DesafioMobile2You
//
//  Created by Douglas Cardoso Ferreira on 01/04/21.
//

import Foundation

struct SimilarMovies: Codable {
    let results: [Movie]
    let total_results: Int
}
