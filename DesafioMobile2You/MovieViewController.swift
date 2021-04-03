//
//  MovieViewController.swift
//  DesafioMobile2You
//
//  Created by Douglas Cardoso Ferreira on 01/04/21.
//

import UIKit

class MovieViewController: UIViewController {
    
    // MARK: Properties
    private var movie: Movie!
    private var similarMovies: SimilarMovies!
    private let id = 550
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var lbMovieTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMovie()
        
        Timer.scheduledTimer(withTimeInterval: 6, repeats: false) { (_) in
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(self.movie.backdrop_path)")
            let data = try? Data(contentsOf: url!)
            self.ivMovie.image = UIImage(data: data!)
            self.lbMovieTitle.text = self.movie.title

        }
        
    }
    
    // MARK: Functions
    func loadMovie() {
        TheMovieDBAPI.getMovie(self.id) { (response) in
            self.movie = response
        } onError: { (error) in
            print(error)
        }
        TheMovieDBAPI.getSimilarMovies(self.id) { (response) in
            self.similarMovies = response
        } onError: { (error) in
            print(error)
        }
    }
    
    func loadImage(path: String) -> UIImage{
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
        let data = try? Data(contentsOf: url!)
        return UIImage(data: data!)!
    }


}

// MARK: UITableViewDataSource, UITableViewDelegate
extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if similarMovies == nil {
            return 1
        }
        return similarMovies.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MoviesTableViewCell
        
        for sMovie in similarMovies.results {
            cell.ivSimilarMovie.image = loadImage(path: sMovie.backdrop_path)
            cell.lbTitleSimilarMovie.text = sMovie.title
            cell.lbGenreSimilarMovie.text = sMovie.release_date
        }
                
        return cell
    }
    
}
