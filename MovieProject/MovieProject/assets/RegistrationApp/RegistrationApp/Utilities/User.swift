//
//  UserNS.swift
//  RegistrationApp
//
//  Created by asmaaashraf on 7/12/19.
//  Copyright © 2019 ThirdDoploma. All rights reserved.
//

import UIKit
import Foundation

class User: NSObject, NSCoding{
   //Model for UserDefault
    
    var email:String!
    var password:String!
    var image: UIImage!
    var name: String!
    var address: String!

    
    init(email: String, password: String, name: String, address: String, image: UIImage) {
        self.email = email
        self.password = password
        self.name = name
        self.address = address
        self.image = image
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.password, forKey: "password")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.address, forKey: "address")
        aCoder.encode(self.image, forKey: "image")



    }

    
    required init?(coder aDecoder: NSCoder) {
        email = aDecoder.decodeObject(forKey: UserDefaultsKeys.email) as? String ?? ""
        password = aDecoder.decodeObject(forKey: UserDefaultsKeys.password) as? String ?? ""
        name = aDecoder.decodeObject(forKey: UserDefaultsKeys.name) as? String ?? ""
        address = aDecoder.decodeObject(forKey: UserDefaultsKeys.address) as? String ?? ""
        image = aDecoder.decodeObject(forKey: UserDefaultsKeys.image) as? UIImage
     }
    
}
    
