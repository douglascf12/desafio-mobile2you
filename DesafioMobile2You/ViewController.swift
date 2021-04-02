//
//  ViewController.swift
//  DesafioMobile2You
//
//  Created by Douglas Cardoso Ferreira on 01/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var movie: Movie!
    private var similarMovies: SimilarMovies!
    private let id = 550

    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovie()
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (_) in
            if let vc = UIStoryboard(name: "Movie", bundle: nil).instantiateViewController(withIdentifier: "Movie") as? MovieTableViewController {
                vc.movie = self.movie
                vc.similarMovies = self.similarMovies
                self.present(vc, animated: true, completion: nil)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MovieTableViewController
        vc.movie = movie
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
