//
//  MovieManager.swift
//  DesafioMobile2You
//
//  Created by Douglas Cardoso Ferreira on 04/04/21.
//

import UIKit

class MovieManager {
    
    static let shared = MovieManager()
    var movie: Movie!
    var similarMovies: SimilarMovies!
    
    func downloadImage(path: String) -> UIImage {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
        let data = try? Data(contentsOf: url!)
        return UIImage(data: data!)!
    }
    
    private init() {
    }
    
}
