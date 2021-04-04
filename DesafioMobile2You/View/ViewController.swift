//
//  ViewController.swift
//  DesafioMobile2You
//
//  Created by Douglas Cardoso Ferreira on 01/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    private let id = 550
    let movieManager = MovieManager.shared
    
    // MARK: - IBOutlets
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var label: UILabel!

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        aiLoading.startAnimating()
        loadMovie()
                
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (_) in
            if let vc = UIStoryboard(name: "Movie", bundle: nil).instantiateViewController(withIdentifier: "Movie") as? MovieTableViewController {
                self.present(vc, animated: true, completion: nil)
            }
        }
        
    }
    
    func loadMovie() {
        TheMovieDBAPI.getMovie(self.id) { (res) in
            self.movieManager.movie = res
        } onError: { (error) in
            print(error)
        }
        TheMovieDBAPI.getSimilarMovies(self.id) { (res) in
            self.movieManager.similarMovies = res
        } onError: { (error) in
            print(error)
        }
    }
    
}
