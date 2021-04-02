//
//  ViewController.swift
//  DesafioMobile2You
//
//  Created by Douglas Cardoso Ferreira on 01/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    private var movie: Movie?
    private var similarMovies: SimilarMovies?
    private let id = 150
    
    // MARK: - IBOutlets
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        aiLoading.startAnimating()
        loadMovie()
                
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (_) in
            if let vc = UIStoryboard(name: "Movie", bundle: nil).instantiateViewController(withIdentifier: "Movie") as? MovieTableViewController {
                vc.movie = self.movie!
                vc.similarMovies = self.similarMovies!
                self.present(vc, animated: true, completion: nil)
            }
            self.aiLoading.stopAnimating()
        }
        
    }
    
    func loadMovie() {
        TheMovieDBAPI.getMovie(self.id) { (res) in
            self.movie = res
        } onError: { (error) in
            print(error)
        }
        TheMovieDBAPI.getSimilarMovies(self.id) { (res) in
            self.similarMovies = res
        } onError: { (error) in
            print(error)
        }
    }
    
}
