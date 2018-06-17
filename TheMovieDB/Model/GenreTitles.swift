//
//  GenreTitles.swift
//  TheMovieDB
//
//  Created by Kanat on 17.06.2018.
//  Copyright © 2018 Rustem. All rights reserved.
//

import Foundation

struct GenreTitles: Decodable {
    var genres: [Genres]
    
    init(genres: [Genres]){
        self.genres = genres
    }
}

struct Genres: Decodable {
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
