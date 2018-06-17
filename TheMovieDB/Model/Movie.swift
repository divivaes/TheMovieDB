//
//  Movie.swift
//  TheMovieDB
//
//  Created by Kanat on 17.06.2018.
//  Copyright © 2018 Rustem. All rights reserved.
//

import UIKit



struct Movie: Decodable {
    var results: [Results]
    
    init(results: [Results]){
        self.results = results
    }
}

struct Results: Decodable{
    var vote_average: Float
    var title: String
    var poster_path: String
    var overview: String
    var id: Int
    
    init(title: String, vote_average: Float, poster_path: String, overview: String, id: Int){
        self.title = title
        self.vote_average = vote_average
        self.poster_path = poster_path
        self.overview = overview
        self.id = id
    }
}


