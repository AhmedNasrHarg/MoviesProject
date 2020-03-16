//
//  ViewController.swift
//  RegistrationApp
//
//  Created by asmaaashraf on 7/2/19.
//  Copyright © 2019 ThirdDoploma. All rights reserved.
//
//            cell.imageView.sd_setImageWithURL(url, placeholderImage:nil, completed: { (image, error, cacheType, url) -> Void in

import UIKit
import MarqueeLabel
import TextFieldEffects

class SignInVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var email_tf: MarqueeLabel!
    @IBOutlet weak var password_tf: MarqueeLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let  imageURL = URL(string: "https://miro.medium.com/max/945/1*fQOFEVFxxjWDm5fEEec4jg.jpeg")!
      imageView?.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "3"))
        
        
        
        self.navigationItem.title = "Sign In"
    }

    @IBAction func signInBtnPressed(_ sender: UIButton) {
        let email = email_tf.text!
        let password = password_tf.text!
        
        
        if (UserDefaultManager.sharedInstance.userDate?.email) == nil && (UserDefaultManager.sharedInstance.userDate?.password) == nil{
            self.showAlert(title: "Sorry", message: "Enter Vaild Email and Password")
        } else {
            guard let cachedEmail = UserDefaultManager.sharedInstance.userDate?.email as? String, email == cachedEmail else {
                self.showAlert(title: "Sorry", message: "Enter Valid Email and Password")
                return
            }
        }
        
        let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(profileVC, animated: true)

    
}

    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        let signUpVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
