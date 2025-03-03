//
//  MovieDetailsViewController.swift
//  demoApp
//
//  Created by Ashutosh Singh on 02/03/25.
//
import UIKit

class MovieDetailsViewController: UIViewController {
    var movie: Movie?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var ratingLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            navigationItem.title = movie.title

            titleLabel.text = ""
            overviewLabel.text = movie.overview
            ratingLbl.text = "Popularity : \(movie.popularity)"
            if let posterPath = movie.posterPath {
                  let imageUrl = URL(string: "https://image.tmdb.org/t/p/w200\(posterPath)")
                  DispatchQueue.global().async {
                      if let imageUrl = imageUrl, let data = try? Data(contentsOf: imageUrl) {
                          DispatchQueue.main.async {
                              self.ImageView.image = UIImage(data: data)
                          }
                      }
                  }
              }
            
        }
    }
}
