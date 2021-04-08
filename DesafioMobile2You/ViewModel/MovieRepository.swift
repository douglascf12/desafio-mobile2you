//
//  MovieRepository.swift
//  DesafioMobile2You
//
//  Created by Douglas Cardoso Ferreira on 07/04/21.
//

import Foundation
import RxSwift

class MovieRepository {
    
    private let movieService = MovieService()
    private let baseURLString = "https://api.themoviedb.org/3/"
    private let key = "898283e2986d30a77df7ff2d9100de5c"
    let idMovie = 550
    
    // método que faz a requisição e traz as informações dos filmes similares
    func getSimilarMovies() -> Observable<[Movie]> {
        return Observable.create { observer -> Disposable in
            let dataTask = self.movieService.getAllMovies(from: self.baseURLString + "movie/\(self.idMovie)/similar?api_key=\(self.key)") { result in
                switch result {
                case .success(let allMovies):
                    observer.onNext(allMovies)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }
    
    // método que faz o download de uma imagem a partir da url
    func downloadImage(path: String) -> UIImage {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
        let data = try? Data(contentsOf: url!)
        return UIImage(data: data!)!
    }
    
}
