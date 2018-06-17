//
//  FeaturedMoviesViewController.swift
//  TheMovieDB
//
//  Created by Kanat on 17.06.2018.
//  Copyright © 2018 Rustem. All rights reserved.
//
import UIKit

public let reuseIdentifier = "Cell"
public let apiKey = "02da584cad2ae31b564d940582770598"
public var page = 1

class FeaturedMoviesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchControllerDelegate {
    
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    var results: [Results] = []{
        didSet {
            DispatchQueue.main.async {
                 self.activityIndicatorView.stopAnimating()
                 self.collectionView?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.color = UIColor.rgb(red: 1, green: 210, blue: 119)
        
        let horizontalConstraint = NSLayoutConstraint(item: activityIndicatorView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: activityIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        view.addConstraint(horizontalConstraint)
        view.addConstraint(verticalConstraint)
        
        collectionView?.backgroundColor = .white
        
        self.collectionView!.register(MovieCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        parseData()
        largeTitleSetup()
        
    }
    
    func largeTitleSetup(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 1, green: 210, blue: 119)]
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.tintColor = .white
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }

    func parseData(){
        activityIndicatorView.startAnimating()
        guard let urlFeatured = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=\(page)")
            else { return }
        URLSession.shared.dataTask(with: urlFeatured) { (data, response, error) in
            guard let data = data else { return }
            do {
                let popularData = try JSONDecoder().decode(Movie.self, from: data)
                self.results.append(contentsOf: popularData.results)
            } catch let err{
                print("Err", err)
            }
            
        }.resume()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCell
        let movie = results[indexPath.item]
        cell.titleLabel.attributedText = NSAttributedString(string: movie.title, attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 65, green: 65, blue: 65), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)])
        
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)")
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            if let data = try? Data(contentsOf: imageURL!){
                DispatchQueue.main.async {
                    cell.posterImage.image = UIImage(data: data)
                }
            }
        }
        
            
        cell.descriptionLabel.attributedText = NSAttributedString(string: movie.overview, attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 150, green: 150, blue: 150), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)])
        cell.ratingLabel.attributedText = NSAttributedString(string: "\(movie.vote_average)", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 22)])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == results.count - 1 {
            page = page + 1
            parseData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailedMovieController = DetailedMovieViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let movie = results[indexPath.item]
        detailedMovieController.id = movie.id
        detailedMovieController.movieTitle = movie.title
        navigationController?.pushViewController(detailedMovieController, animated: true)
    }
    
    

}
