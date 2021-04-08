//
//  ViewController.swift
//  DesafioMobile2You
//
//  Created by Douglas Cardoso Ferreira on 01/04/21.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lbLoading: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var lbMovieTitle: UILabel!
    @IBOutlet weak var btMovieLike: UIButton!
    @IBOutlet weak var lbMovieLikes: UILabel!
    @IBOutlet weak var lbPopularity: UILabel!
    
    //MARK: - Properties
    private let movieRepository = MovieRepository()
    private let disposeBag = DisposeBag()
    private var movie: Movie!
    private var like = false

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbLoading.text = "Carregando informações do filme..."
        
        tableView.isHidden = true
        loadInfos()
        let movieObservable = movieRepository.getSimilarMovies().share()
        movieObservable.flatMap { movies -> Observable<[Movie]> in
            return self.movieRepository.getSimilarMovies()
        }.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: MoviesTableViewCell.self)) { index, movie, cell in
            cell.ivSimilarMovie.image = self.movieRepository.downloadImage(path: movie.backdrop_path)
            cell.lbTitleSimilarMovie.text = movie.title
            cell.lbReleaseYear.text = "Ano de lançamento: \(movie.release_date.prefix(4))"
        }.disposed(by: disposeBag)
    }
    
    // método que faz a requisição do filme e seta as informações na tela
    func loadInfos() {
        let movieService = MovieService()
        let idMovie = movieRepository.idMovie
        let urlString = "https://api.themoviedb.org/3/movie/\(idMovie)?api_key=898283e2986d30a77df7ff2d9100de5c"
        
        movieService.getMovie(from: urlString) { movie in
            self.movie = movie
        } onError: { error in
            print(error)
        }
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
            self.ivMovie.image = self.movieRepository.downloadImage(path: self.movie.backdrop_path)
            self.lbMovieTitle.text = self.movie.title
            self.lbMovieLikes.text = "\(self.movie.vote_count)"
            self.lbPopularity.text = "\(self.movie.popularity)"
            self.lbLoading.isHidden = true
            self.tableView.isHidden = false
        }
    }
    
    // MARK: - IBActions
    // função que muda a imagem do botão ao ser clicado
    @IBAction func likeMovie(_ sender: Any) {
        let countLikes = movie.vote_count
        if !like {
            btMovieLike.setImage(UIImage(named: "likeOn"), for: .normal)
            lbMovieLikes.text = "\(countLikes+1)"
            like = true
        } else {
            btMovieLike.setImage(UIImage(named: "likeOff"), for: .normal)
            lbMovieLikes.text = "\(countLikes)"
            like = false
        }
    }

}

