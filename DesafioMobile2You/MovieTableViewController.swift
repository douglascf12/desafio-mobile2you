//
//  MovieTableViewController.swift
//  DesafioMobile2You
//
//  Created by Douglas Cardoso Ferreira on 01/04/21.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    // MARK: - Properties
    var movie: Movie!
    var similarMovies: SimilarMovies!

    override func viewDidLoad() {
        super.viewDidLoad()

        print(movie.original_title)
        print(similarMovies.results.count)
    }
    
    func loadImage(path: String) -> UIImage{
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
        let data = try? Data(contentsOf: url!)
        return UIImage(data: data!)!
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return similarMovies.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MoviesTableViewCell

        let m = similarMovies.results[indexPath.row]
        cell.prepare(with: m)

        return cell
    }

}
