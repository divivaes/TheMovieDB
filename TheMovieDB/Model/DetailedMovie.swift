//
//  DetailedMovie.swift
//  TheMovieDB
//
//  Created by Kanat on 17.06.2018.
//  Copyright © 2018 Rustem. All rights reserved.
//

import Foundation

struct DetailedMovie: Decodable {
    var backdrop_path: String = ""
    var overview: String = ""
    var poster_path: String = ""
    var runtime: Int = 0
    var title: String = ""
    var vote_average: Float = 0
}
