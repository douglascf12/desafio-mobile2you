//
//  MovieService.swift
//  DesafioMobile2You
//
//  Created by Douglas Cardoso Ferreira on 07/04/21.
//

import Foundation
import RxSwift

class MovieService {
    
    // método que faz a requisição e traz as informações de um filme
    func getMovie(from url: String, completion: @escaping (Movie) -> Void, onError: @escaping (Error) -> Void) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if let error = error {
                onError(error)
            }
            guard let data = data else {
                let error = NSError(domain: "dataNilError", code: -10001, userInfo: nil)
                onError(error); return
            }
            do {
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                completion(movie)
            } catch {
                onError(error)
            }
        }
        task.resume()
    }
    
    // método que faz a requisição e traz as informações dos filmes similares
    func getAllMovies(from url: String, completion: @escaping ((Result<[Movie], Error>) -> Void)) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if let error = error {
                completion(.failure(error)); return
            }
            guard let data = data else {
                let error = NSError(domain: "dataNilError", code: -10001, userInfo: nil)
                completion(.failure(error)); return
            }
            do {
                let similarMovies = try JSONDecoder().decode(SimilarMovies.self, from: data)
                completion(.success(similarMovies.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
        return task
    }
    
}
