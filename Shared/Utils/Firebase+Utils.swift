//
//  Firebase+Utils.swift
//  Artable
//
//  Created by Thinkitive on 02/09/21.
//

import Firebase


extension Auth {
    func handleFireAuthError(error : Error ,vc : UIViewController) {
        
        if let errorCode = AuthErrorCode(rawValue : error._code) {
            let alert = UIAlertController(title: "Error", message: errorCode.errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            vc.present(alert, animated: true, completion: nil)
        }
    }
}

extension AuthErrorCode {
    var errorMessage : String{
        switch self {
        case .emailAlreadyInUse :
            return "The email is already used in Another Account.Pick another One"
        case .userNotFound :
            return "Account Not Found for the specific user"
        case .userDisabled:
            return "Your account has been disbaled,Please contact support"
        case .invalidEmail ,.invalidSender,.invalidRecipientEmail :
            return "Please enter valid email"
        case .networkError :
            return "Network Error.Please try Again"
        case .weakPassword:
            return "Your password is too weak.The password must be 6 characters long or more"
        case .wrongPassword :
            return "Your passwordor email is incorrect"
        default:
            return "Sorry,Something Went Wrong"
        }
    }
}
