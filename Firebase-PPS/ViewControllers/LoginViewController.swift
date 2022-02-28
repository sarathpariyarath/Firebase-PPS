//
//  ViewController.swift
//  Firebase-PPS
//
//  Created by Sarath P on 28/02/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
        
            }
        }
    }
}

