//
//  ContactVC.swift
//  RegistrationApp
//
//  Created by asmaaashraf on 7/23/19.
//  Copyright © 2019 ThirdDoploma. All rights reserved.
//

import UIKit

class ContactVC: UIViewController {

    @IBOutlet weak var userName: UILabel!
    
    
    @IBOutlet weak var userAddress: UILabel!
    
    
    @IBOutlet weak var userEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 //let userData =  UserDefaultManager.sharedInstance.userDate as! Data
        
//        let userData = UserDefaults.standard.value(forKey: "name") as! Data

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

     @IBOutlet weak var userAddress: UILabel!
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
