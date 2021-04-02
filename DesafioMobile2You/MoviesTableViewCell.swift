//
//  MoviesTableViewCell.swift
//  DesafioMobile2You
//
//  Created by Douglas Cardoso Ferreira on 01/04/21.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    //MARK: Properties
    var similarMovies: [SimilarMovies] = []
    
    //MARK: IBOutlets
    @IBOutlet weak var ivSimilarMovie: UIImageView!
    @IBOutlet weak var lbTitleSimilarMovie: UILabel!
    @IBOutlet weak var lbGenreSimilarMovie: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with movie: Movie) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdrop_path)")
        let data = try? Data(contentsOf: url!)
        ivSimilarMovie.image = UIImage(data: data!)
        //lbTitleSimilarMovie.text = movie.original_title
        //lbGenreSimilarMovie.text = movie.release_date
    }

}
