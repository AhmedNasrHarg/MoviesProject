//
//  Post.swift
//  RegistrationApp
//
//  Created by asmaaashraf on 8/1/19.
//  Copyright © 2019 ThirdDoploma. All rights reserved.
//

import Foundation
struct Post: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
    
//    private enum CodeingKeys: String, CodingKey{
//        case userId
//        case id
//        case myTitle = "title"
//        case body
//    }
    
}
