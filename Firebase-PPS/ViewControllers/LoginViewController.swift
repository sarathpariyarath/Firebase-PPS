//
//  ViewController.swift
//  Firebase-PPS
//
//  Created by Sarath P on 28/02/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let firebaseManager = FirebaseManager.sharedInstance
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Reading userDefaults
        userLoggedInCheck()
        
        self.title = "Login"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        
        let username = emailTextField.text!
        let password = passWordTextField.text!
        passWordTextField.text = ""
        emailTextField.text = ""
        passWordTextField.endEditing(true)
        
        FirebaseManager.sharedInstance.loginUserFirebase(email: username, password: password, loader: true, view: self) { status in
            if status == true {
                self.firebaseManager.userDefaults.set(true, forKey: "userLog")
                 let insideView = self.storyboard?.instantiateViewController(withIdentifier: "InsideViewController") as! InsideViewController
                self.navigationController?.pushViewController(insideView, animated: true)
            }
        }
    }
    
    //Function For Checking User have logged In
    func userLoggedInCheck() {
        if firebaseManager.userDefaults.bool(forKey: "userLog") == true {
            let insideView = self.storyboard?.instantiateViewController(withIdentifier: "InsideViewController") as! InsideViewController
            self.navigationController?.pushViewController(insideView, animated: true)
        }
    }
}

