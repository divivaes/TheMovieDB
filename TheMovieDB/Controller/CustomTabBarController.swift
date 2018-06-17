//
//  CustomTabBarController.swift
//  TheMovieDB
//
//  Created by Kanat on 17.06.2018.
//  Copyright © 2018 Rustem. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let moviesVC = FeaturedMoviesViewController(collectionViewLayout: UICollectionViewFlowLayout())
        moviesVC.navigationItem.title = "Popular movies"
        let navigationController = UINavigationController(rootViewController: moviesVC)
        navigationController.title = "Movies"
        navigationController.tabBarItem.image = UIImage(named: "movie")
        
        let genreVC = GenreViewController()
        genreVC.navigationItem.title = "Genres"
        let secondNavigationController = UINavigationController(rootViewController: genreVC)
        secondNavigationController.title = "Genre"
        secondNavigationController.tabBarItem.image = UIImage(named: "list")
        

        
        viewControllers = [navigationController, secondNavigationController]
       
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor.lightGray.cgColor

        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
    }
    
    @objc func selectMovie(){
        
    }
    
}
