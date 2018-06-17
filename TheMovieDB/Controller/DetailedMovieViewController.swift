//
//  DetailedMovieViewController.swift
//  TheMovieDB
//
//  Created by Kanat on 17.06.2018.
//  Copyright © 2018 Rustem. All rights reserved.
//

import UIKit

class DetailedMovieViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var id = 0
    var movieTitle = ""
    var myData = DetailedMovie()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = movieTitle
        parseData()
        self.collectionView!.register(DetailedMovieCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        largeTitleSetup()
    }
    
    func largeTitleSetup(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 1, green: 210, blue: 119)]
    }
    
    func parseData(){
        guard let urlFeatured = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=en-US")
            else { return }
        URLSession.shared.dataTask(with: urlFeatured) { (data, response, error) in
            guard let data = data else { return }
            do {
                let popularData = try JSONDecoder().decode(DetailedMovie.self, from: data)
                self.myData = popularData
                print(popularData)
            } catch let err{
                print("Err", err)
            }
            
            }.resume()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DetailedMovieCell
        
        cell.titleLabel.attributedText = NSAttributedString(string: myData.title, attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 65, green: 65, blue: 65), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 25)])

        let backgound = URL(string: "https://image.tmdb.org/t/p/w500\(myData.backdrop_path)")
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            if let data = try? Data(contentsOf: backgound!){
                DispatchQueue.main.async {
                    cell.backgroundImage.image = UIImage(data: data)
                }
            }
        }

        let poster = URL(string: "https://image.tmdb.org/t/p/w500\(myData.poster_path)")
        queue.async {
            if let data = try? Data(contentsOf: poster!){
                DispatchQueue.main.async {
                    cell.posterImage.image = UIImage(data: data)
                }
            }
        }

        cell.descriptionLabel.attributedText = NSAttributedString(string: myData.overview, attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 150, green: 150, blue: 150), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)])
        cell.runtime.attributedText = NSAttributedString(string: "\(myData.runtime) min", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 700)
    }
    
}
