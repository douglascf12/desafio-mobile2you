//
//  NetworkService.swift
//  DesafioMobile2You
//
//  Created by Douglas Cardoso Ferreira on 07/04/21.
//

import Foundation
import RxSwift

class NetworkService {
    
    func execute<T: Decodable>(url: URL) -> Observable<T> {
        return Observable.create { observer -> Disposable in
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data, let decoded = try? JSONDecoder().decode(T.self, from: data) else {
                    return
                }
                observer.onNext(decoded)
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
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
