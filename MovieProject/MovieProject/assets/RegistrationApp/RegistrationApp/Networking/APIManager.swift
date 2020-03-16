//
//  APIManager.swift
//  RegistrationApp
//
//  Created by MacOSSierra on 7/25/19.
//  Copyright © 2019 ThirdDoploma. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    static func getPost(completion: @escaping (_ error: String?,_ posts: [Post]?) -> Void){
        let url = "https://jsonplaceholder.typicode.com/posts?fbclid=IwAR209RnBd6weZhT-bz-bHUb4F2Fxoai0FsfgyMox17d-bOwnnOOQdRcv2-s"
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
            case.failure( let error):
                print(error.localizedDescription)
                completion(error.localizedDescription,nil)
            case.success(_):
                print(response.result.value)
                guard let data = response.data else {
                    print("did not get any data from Api")
                    completion("did not get any data from Api",nil)
                    return
                }
                do{
                let posts = try JSONDecoder().decode([Post].self, from: data)
                    print(posts.first?.title)
                    completion(nil,posts)
                }catch{
                    print("error")
                    print(error.localizedDescription)
                    completion("error",nil)
                    
                }
            }
            
        }
    }
    
}

