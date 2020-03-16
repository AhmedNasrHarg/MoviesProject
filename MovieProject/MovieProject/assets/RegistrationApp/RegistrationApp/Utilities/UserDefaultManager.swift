//
//  File.swift
//  RegistrationApp
//
//  Created by asmaaashraf on 7/8/19.
//  Copyright © 2019 ThirdDoploma. All rights reserved.
//

import Foundation
class UserDefaultManager {
    
    private init() {}
    
    static let sharedInstance = UserDefaultManager ()
    let  def = UserDefaults.standard
    
    var isLoggedIn : Bool? {
        get {
            guard let isLoggedIn = def.object(forKey: UserDefaultsKeys.isLogIn) as? Bool else {
                return false
                 }
            return isLoggedIn
        }set {
            def.set(newValue, forKey: UserDefaultsKeys.isLogIn)
        }
    }
    
    var userDate: User? {
        get {
            if let saveUser = def.object(forKey: UserDefaultsKeys.userData) as? Data {
                
                let  deceded = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(saveUser) as? User
                
                return deceded as! User
                
            }
            return nil
        } set {
            if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: newValue!, requiringSecureCoding: false){
                let def = UserDefaults.standard
                def.set(saveData, forKey: UserDefaultsKeys.userData)
            }
        }

//var email: String {
//    get {
//        return UserDefaults.standard.string(forKey: UserDefaultsKeys.email)!
//    }
//    set {
//        UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.email)
//    }
//
//    }

    
    }
    
    
    


}
