//
//  ForgotPasswordVC.swift
//  Artable
//
//  Created by Thinkitive on 02/09/21.
//

import UIKit
import Firebase

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }


    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetClicked(_ sender: Any) {
        guard let email = emailText.text , email.isNotEmpty else {
            simpleAlert(title: "Error", msg: "Please enter email")
            return
        }
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error , vc: self)
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
