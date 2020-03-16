//
//  ReviewModel.swift
//  MovieProject
//
//  Created by MacOSSierra on 3/16/20.
//  Copyright © 2020 ITI. All rights reserved.
//

import UIKit

class ReviewModel: NSObject {
    let author: String
    let content: String
    init( Author:String, Content: String) {
        author = Author
        content = Content
    }
}
