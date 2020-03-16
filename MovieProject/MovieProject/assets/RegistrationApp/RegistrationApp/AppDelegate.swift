//
//  AppDelegate.swift
//  RegistrationApp
//
//  Created by asmaaashraf on 7/2/19.
//  Copyright © 2019 ThirdDoploma. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
//    var posts: [Post] = []


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        //let userLogOutStatus = UserDefaults.standard.bool(forKey: "LogOutBtn")
        
        if UserDefaultManager.sharedInstance.isLoggedIn == true && UserDefaultManager.sharedInstance.userDate != nil{
            let profile = UIStoryboard (name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
            window!.rootViewController = profile
            window!.makeKeyAndVisible()
        } else {
          print("NO Data")
        }
     
        //APIManager.getposts()
//        APIManager.getPost { (error, posts) in
//            if  let error = error{
//                //self.showAlert(title: "sorry",message: error)
//            }else if let posts = posts{
//                self.posts = posts
//                //law feh table view delw2ty kona 7nady 3aleha tany 3shan ta5od data lama tegy w y3rdha
//                print(posts.first?.body)
//            }
//        }
        
        return true
        
        IQKeyboardManager.shared.enable = true

    }
        // Override point for customization after application launch.
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

