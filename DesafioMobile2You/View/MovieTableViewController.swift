//
//  MovieTableViewController.swift
//  DesafioMobile2You
//
//  Created by Douglas Cardoso Ferreira on 01/04/21.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    // MARK: - Properties
    let movieManager = MovieManager.shared
    var like = false
    
    // MARK: - IBOutlets
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var lbMoviteTitle: UILabel!
    @IBOutlet weak var btLikeMovie: UIButton!
    @IBOutlet weak var lbLikesMovie: UILabel!
    @IBOutlet weak var lbPopularityMovie: UILabel!
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        ivMovie.image = movieManager.downloadImage(path: movieManager.movie.backdrop_path)
        lbMoviteTitle.text = movieManager.movie.title
        lbLikesMovie.text = "\(movieManager.movie.vote_count)"
        lbPopularityMovie.text = "\(movieManager.movie.popularity)"
    }
    
    func loadImage(path: String) -> UIImage {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
        let data = try? Data(contentsOf: url!)
        return UIImage(data: data!)!
    }
    
    // MARK: - IBActions
    @IBAction func likeMovie(_ sender: Any) {
        let countLikes = movieManager.movie.vote_count
        if !like {
            btLikeMovie.setImage(UIImage(named: "likeOn"), for: .normal)
            lbLikesMovie.text = "\(countLikes+1)"
            like = true
        } else {
            btLikeMovie.setImage(UIImage(named: "likeOff"), for: .normal)
            lbLikesMovie.text = "\(countLikes)"
            like = false
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieManager.similarMovies.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MoviesTableViewCell

        let similarMovie = movieManager.similarMovies.results[indexPath.row]
        let image = movieManager.downloadImage(path: movieManager.similarMovies.results[indexPath.row].backdrop_path)
        cell.prepare(similarMovie, image)

        return cell
    }
    
    

}
