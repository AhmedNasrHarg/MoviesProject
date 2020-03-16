//
//  Movie.swift
//  MovieProject
//
//  Created by MacOSSierra on 3/12/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class MovieModel: NSObject {
    let id: Int
    let posterPath: String
    let title: String
    let releaseDate: String
    let rating: Double
    let overview: String
    
     init( Id:Int, PosterPath:String, Title:String, ReleaseDate: String, Rating:Double, Overview:String) {
        id=Id;
        posterPath=PosterPath
        title=Title
        releaseDate=ReleaseDate
        rating=Rating
        overview=Overview
    }

}
