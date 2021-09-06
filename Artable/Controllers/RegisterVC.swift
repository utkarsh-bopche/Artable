//
//  RegisterVC.swift
//  Artable
//
//  Created by Apple on 29/08/21.
//

import UIKit
import Firebase


class RegisterVC: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPassTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var passCheckImg: UIImageView!
    @IBOutlet weak var confirmPassCheckImg: UIImageView!
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        confirmPassTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        // Do any additional setup after loading the view.
    }
    
    //MARK:-Private Methods
    @objc func textFieldDidChange(_ textField: UITextField){
        //If we have started type in cnfirm pass text field
        guard let passTxt = passwordTxt.text else {return}
        if textField == confirmPassTxt {
            passCheckImg.isHidden = false
            confirmPassCheckImg.isHidden = false
        } else {
            if passTxt.isEmpty {
                passCheckImg.isHidden = true
                confirmPassCheckImg.isHidden = true
                confirmPassTxt.text = ""
            }
        }
        
        // Make it so whrn the password match , the checkmarks turn green
        if passwordTxt.text == confirmPassTxt.text{
            passCheckImg.image = UIImage(named: AppImages.greenCheck)
            confirmPassCheckImg.image = UIImage(named: AppImages.greenCheck)
        }else {
            passCheckImg.image = UIImage(named: AppImages.redCheck)
            confirmPassCheckImg.image = UIImage(named: AppImages.redCheck)
        }
    }
    //MARK:- IBActions
    @IBAction func registerClicked(_ sender: Any) {
        guard let email = emailTxt.text , email.isNotEmpty ,
              let username = usernameTxt.text , username.isNotEmpty ,
              let password = passwordTxt.text , password.isNotEmpty else {
            simpleAlert(title: "Error", msg: "Please fill out all fields")
            return
        }
        guard let confirmPass = confirmPassTxt.text , confirmPass == password else {
            simpleAlert(title: "Error", msg: "Password do not match")
            return
        }
        
        activityIndicator.startAnimating()
        
        guard let authUser = Auth.auth().currentUser else {
            return
        }
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        authUser.link(with: credential) { (result ,error) in
            if let error = error {
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error , vc: self)
                return
            }
            self.activityIndicator.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//            if let error = error {
//                debugPrint(error)
//                return
//            }
//            self.activityIndicator.stopAnimating()
//            self.dismiss(animated: true, completion: nil)
//        }
    }
    
    
}
