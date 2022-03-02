//
//  InsideViewController.swift
//  Firebase-PPS
//
//  Created by Sarath P on 01/03/22.
//

import UIKit
import FirebaseAuth

class InsideViewController: UIViewController {

    let email = Auth.auth().currentUser?.email
    let firebaseManager = FirebaseManager.sharedInstance
    
    @IBOutlet weak var msgDisplayLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var userEmailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "Login Success"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.setHidesBackButton(true, animated: true)  
        
        userEmailLabel.text = email
        
        firebaseManager.chatObserver { value in
            let valueString = value as! String
            print(valueString)
            self.msgDisplayLabel.text = valueString
        }
    }
    //Signout Clicked
    @IBAction func signOutBtnPressed(_ sender: Any) {
        firebaseManager.signOutUserFirebase { status in
            if status == true {
                firebaseManager.userDefaults.set(false, forKey: "userLog")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    //Send Button Clicked
    @IBAction func sendBtnClicked(_ sender: Any) {
        let message = messageTextField.text
        
        if message?.isEmpty == true {
            AlertManager.sharedInstance.alert(view: self, messages: "Please Enter Something")
        } else {
            firebaseManager.newMessage(message: message ?? "nil")
        }
    }
    
}
