//
//  TheMovieDBAPI.swift
//  DesafioMobile2You
//
//  Created by Douglas Cardoso Ferreira on 01/04/21.
//

import Foundation

enum MovieError {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}

class TheMovieDBAPI {

    private static let basePath = "https://api.themoviedb.org/3/"
    private static let key = "898283e2986d30a77df7ff2d9100de5c"

    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true // permitir acesso por rede de dados móveis
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()

    private static let session = URLSession(configuration: configuration)

    class func authenticate(onComplete: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(basePath)authentication/token/new?api_key=\(key)") else {
            onComplete(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let _ = data else {
                    onComplete(false)
                    return
                }
                onComplete(true)
            } else {
                onComplete(false)
            }
        }
        dataTask.resume()
    }

    class func getMovie(_ id: Int, onComplete: @escaping (Movie) -> Void, onError: @escaping (MovieError) -> Void) {
        guard let url = URL(string: "\(basePath)movie/\(id)?api_key=\(key)") else {
            onError(.url)
            return
        }
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                if response.statusCode == 200 {
                    guard let data = data else {return}
                    do {
                        let movie = try JSONDecoder().decode(Movie.self, from: data)
                        onComplete(movie)
                    } catch {
                        print(error.localizedDescription)
                        onError(.invalidJSON)
                    }
                } else {
                    print("Algum status inválido pelo servidor!!")
                    onError(.responseStatusCode(code: response.statusCode))
                }
            } else {
                onError(.taskError(error: error!))
            }
        }
        dataTask.resume()
    }
    
    class func getSimilarMovies(_ id: Int, onComplete: @escaping (SimilarMovies) -> Void, onError: @escaping (MovieError) -> Void) {
        guard let url = URL(string: "\(basePath)movie/\(id)/similar?api_key=\(key)") else {
            onError(.url)
            return
        }
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                if response.statusCode == 200 {
                    guard let data = data else {return}
                    do {
                        let similarMovies = try JSONDecoder().decode(SimilarMovies.self, from: data)
                        onComplete(similarMovies)
                    } catch {
                        print(error.localizedDescription)
                        onError(.invalidJSON)
                    }
                } else {
                    print("Algum status inválido pelo servidor!!")
                    onError(.responseStatusCode(code: response.statusCode))
                }
            } else {
                onError(.taskError(error: error!))
            }
        }
        dataTask.resume()
    }

}
