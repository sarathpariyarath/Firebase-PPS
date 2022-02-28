//
//  Firebase Manager.swift
//  Firebase-PPS
//
//  Created by Sarath P on 01/03/22.
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class FirebaseManager {
    
    static let sharedInstance = FirebaseManager()
    
    //Create New Acc
    func createNewAccount(email: String, password: String, loader: Bool, view: UIViewController, completion: @escaping (_ status: Bool) -> ()) {
        
        if loader == true {
            SVProgressHUD.show(withStatus: "Creating Account")
            SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error == nil {
                
                print("SignUp Success")
                SVProgressHUD.dismiss()
                completion(true)
                
            } else {
                
                SVProgressHUD.dismiss()
                AlertManager.sharedInstance.alert(view: view, messages: error!.localizedDescription)
                
            }
        }
    }
    
    //Login Existing User
    
    func loginUserFirebase(email: String, password: String, loader: Bool, view: UIViewController, completion: (_ status: Bool) -> ()) {
        
        if loader == true {
            SVProgressHUD.show(withStatus: "Loging In")
            SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authRestult, error in
            if error == nil {
                SVProgressHUD.showSuccess(withStatus: "Sign In Success")
                SVProgressHUD.dismiss(withDelay: 3)
            } else {
                SVProgressHUD.dismiss()
                AlertManager.sharedInstance.alert(view: view, messages: error!.localizedDescription)
            }
        }
        
    }
    
}
