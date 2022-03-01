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
import FirebaseDatabase

class FirebaseManager {
    
    //VerificationId
    var verificationId: String?
    
    static let sharedInstance = FirebaseManager()
    
    //RealtimeDatabase Reference
    var ref: DatabaseReference!
    
    //Chat
    func newMessage(message: String) {
        ref = Database.database().reference()
        ref.child("chats").setValue(["message" : message])
    }
    
    //Chat Observer
    func chatObserver(completion: @escaping (_ value: Any) -> ()) {
        ref = Database.database().reference()
        ref.child("chats").observe(.childChanged) { (snapshot) in
            completion(snapshot.value!)
        }
    }
    
    //Create New Acc
    func createNewAccount(email: String, password: String, loader: Bool, view: UIViewController, completion: @escaping (_ status: Bool) -> ()) {
        
        if loader == true {
            SVProgressHUD.show(withStatus: "Creating Account")
            SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error == nil {
                
                SVProgressHUD.showSuccess(withStatus: "Account Created")
                SVProgressHUD.dismiss(withDelay: 1)
                completion(true)
                
            } else {
                
                SVProgressHUD.dismiss()
                AlertManager.sharedInstance.alert(view: view, messages: error!.localizedDescription)
                
            }
        }
    }
    
    //Login Existing User
    
    func loginUserFirebase(email: String, password: String, loader: Bool, view: UIViewController, completion: @escaping (_ status: Bool) -> ()) {
        
        if loader == true {
            SVProgressHUD.show(withStatus: "Loging In")
            SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authRestult, error in
            if error == nil {
                SVProgressHUD.showSuccess(withStatus: "Sign In Success")
                SVProgressHUD.dismiss(withDelay: 1)
                completion(true)
            } else {
                SVProgressHUD.dismiss()
                AlertManager.sharedInstance.alert(view: view, messages: error!.localizedDescription)
            }
        }
        
    }
    
    func signOutUserFirebase(completion: (_ status: Bool) -> ()) {
        do {
            
            try Auth.auth().signOut()
            completion(true)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func verifyPhoneNumber(phoneNumber: String, view: UIViewController, completion: @escaping (_ status: Bool) -> ()) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationId, error in
            if error == nil {
                self.verificationId = verificationId
                completion(true)
            } else {
                AlertManager.sharedInstance.alert(view: view, messages: error!.localizedDescription)
            }
        }
    }
    
    func verifyOtp(otp: String,view: UIViewController, completion: @escaping (_ status: Bool) -> ()) {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId!, verificationCode: otp)
        Auth.auth().signIn(with: credential) { authResult, error in
            if error == nil {
                completion(true)
            } else {
                AlertManager.sharedInstance.alert(view: view, messages: error!.localizedDescription)
            }
        }
    }
}
