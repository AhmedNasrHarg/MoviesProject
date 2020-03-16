//
//  ProfileVC.swift
//  RegistrationApp
//
//  Created by asmaaashraf on 27/6/19.
//  Copyright © 2019 ThirdDoploma. All rights reserved.
//
//
import UIKit
import MarqueeLabel

class ProfileVC: UIViewController {
//
    @IBOutlet weak var userImage: UIImageView!
//
    override func viewDidLoad() {
        super.viewDidLoad()

//        guard let imageData = UserDefaults.standard.value(forKey: "image") as? Data else {return}
//        let imageFormData = UIImage(data: imageData)!
//        userImage.image = imageFormData

        
        guard let user = UserDefaultManager.sharedInstance.userDate else {return}
        userImage.image = user.image
        FirstName.text = user.name
        SecondName.text = user.address
        UserDefaultManager.sharedInstance.isLoggedIn = true
    }
    
    
    
    
    @IBOutlet weak var FirstName: MarqueeLabel!
    
    @IBOutlet weak var SecondName: MarqueeLabel!

    
    @IBAction func LogOutBtn(_ sender: Any) {
        
        let out = UserDefaults.standard
       // out.removeObject(forKey: UserDefaultsKeys.userData)
        UserDefaultManager.sharedInstance.isLoggedIn = false
        out.synchronize()
        
        let signInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        appDel.window!.rootViewController = UINavigationController(rootViewController: signInVC)
        appDel.window!.makeKeyAndVisible()
        
    
}
}
