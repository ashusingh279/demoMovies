//
//  SearchViewController.swift
//  demoApp
//
//  Created by Ashutosh Singh on 01/03/25.
//

import UIKit


class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        navigationItem.title = "Movies"
        fetchMovies()
    }
    
    func fetchMovies() {
        Task {
            await APIClient.shared.fetchTrendingMovies { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let movies):
                        self.movies = movies
                        self.tableView.reloadData()
                    case .failure(let error):
                        print("Error fetching movies: \(error)")
                    }
                }
            }
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)   {
        guard let query = searchBar.text, !query.isEmpty else { return }
 
        Task {
            await APIClient.shared.fetchTrendingMovies { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let movies):
                        self.movies = movies
                        self.tableView.reloadData()
                    case .failure(let error):
                        print("Error fetching movies: \(error)")
                    }
                }
            }
        }
    }
 }

extension SearchViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        
        
        cell.TitleLbl?.text = movie.title
        cell.DescLbl?.text = "Release Date: \(movie.releaseDate ?? "")"
 
        
        if let posterPath = movie.posterPath {
                let imageUrl = URL(string: "https://image.tmdb.org/t/p/w200\(posterPath)")
                DispatchQueue.global().async {
                    if let imageUrl = imageUrl, let data = try? Data(contentsOf: imageUrl) {
                        DispatchQueue.main.async {
                            cell.ImageView.image = UIImage(data: data)
                        }
                        CoreDataManager.shared.saveMovie(id: movie.id, title: movie.title, releaseDate: movie.releaseDate, overview: movie.overview, voteAverage: movie.voteAverage, imageData: data)
                    }
                }
            }
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        detailsVC.movie = movie
        navigationController?.pushViewController(detailsVC, animated: true)
    }

}
