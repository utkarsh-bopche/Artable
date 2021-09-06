//
//  LoginVC.swift
//  Artable
//
//  Created by Apple on 29/08/21.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    //MARK:- IBActions
    @IBAction func forgotPassClicked(_ sender: Any) {
        let vc = ForgotPasswordVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        guard let email = emailTxt.text , email.isNotEmpty ,
              let password = passTxt.text , password.isNotEmpty else {
            simpleAlert(title: "Error", msg: "Please fill out all fields")
            return
            
        }
        activityIndicator.startAnimating()
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                Auth.auth().handleFireAuthError(error: error , vc: self)
                self.activityIndicator.stopAnimating()
                return
            }
            self.activityIndicator.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func guestClicked(_ sender: Any) {
        
    }
    

}
