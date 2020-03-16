//
//  UIViewController+ShowAlert.swift
//  RegistrationApp
//
//  Created by asmaaashraf on 7/2/19.
//  Copyright © 2019 ThirdDoploma. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
