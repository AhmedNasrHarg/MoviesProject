//
//  SignUpVC.swift
//  RegistrationApp
//
//  Created by asmaaashraf on 7/2/19.
//  Copyright © 2019 ThirdDoploma. All rights reserved.
//

import UIKit
import Foundation
import MarqueeLabel
import SDWebImage


class SignUpVC: UIViewController {

//    imageView.sd_setImage(with: URL(string: "http://www.domain.com/path/to/image.jpg"), placeholderImage: UIImage(named: "placeholder.png"))

    @IBOutlet weak var user_iv: UIImageView!
    @IBOutlet weak var email_tf: MarqueeLabel!
    @IBOutlet weak var password_tf: MarqueeLabel!
    @IBOutlet weak var name_tf: MarqueeLabel!
    @IBOutlet weak var address_tf: MarqueeLabel!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sign Up"
    }
    private func saveCredentials(email: String, password: String, name: String, address: String, image: UIImage) {
        

        let user = User.init(email: email, password: password, name: name, address: address, image: image)
    
        UserDefaultManager.sharedInstance.userDate = user
        
    }
    
    @IBAction func SignUpBtnPressed(_ sender: UIButton) {
        let image = user_iv.image
        let placeHolderImage = UIImage(named: "3")
        
        guard let email = email_tf.text, !email.isBlank, let password = password_tf.text, !password.isBlank, let name = name_tf.text, !name.isBlank, let address = address_tf.text, !address.isBlank, image != placeHolderImage
            else {
                self.showAlert(title: "Sorry", message: "Fields is not Valid")
                return
        }
        guard isValidEmailAddress(emailAddressString: email) else {
            self.showAlert(title: "Sorry", message: "Email is not Valid")
            return
        }
        guard isValidPassword(passwordString: password) else {
            self.showAlert(title: "Sorry", message: "Password Must have 8 Characters")
            return
        }
        
        self.saveCredentials(email: email, password: password, name: name, address: address, image: image! )
        
        self.navigationController?.popViewController(animated: true)
        
    }
   
    
    
    
    @IBAction func imagePickerBtnPressed(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
}

extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        user_iv.image = selectedImage
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
