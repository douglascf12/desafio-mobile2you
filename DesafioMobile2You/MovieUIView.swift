//
//  MovieUIView.swift
//  DesafioMobile2You
//
//  Created by Douglas Cardoso Ferreira on 07/04/21.
//

import UIKit

class MovieUIView: UIView {

    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var lbMovieTitle: UILabel!
    @IBOutlet weak var btLikeMovie: UIButton!
    @IBOutlet weak var lbLikesMovie: UILabel!
    @IBOutlet weak var lbPopularityMovie: UILabel!
    
    private var movie: Movie!

}
