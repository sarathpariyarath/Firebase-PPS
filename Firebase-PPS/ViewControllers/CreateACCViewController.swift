//
//  CreateACCViewController.swift
//  Firebase-PPS
//
//  Created by Sarath P on 01/03/22.
//

import UIKit
import FirebaseAuth

class CreateACCViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Create Account"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        emailTextField.text = ""
        passwordTextField.text = ""
        passwordTextField.endEditing(true)
        
        
        FirebaseManager.sharedInstance.createNewAccount(email: email, password: password, loader: true, view: self) { status in
            if status == true {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }

}
