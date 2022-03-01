//
//  PhoneSignUpViewController.swift
//  Firebase-PPS
//
//  Created by Sarath P on 01/03/22.
//

import UIKit

class PhoneSignUpViewController: UIViewController {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Sign up using phone"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    

    @IBAction func sendCodeClicked(_ sender: Any) {
        let phoneNumber = "+91\(phoneNumberTextField.text!)"
        FirebaseManager.sharedInstance.verifyPhoneNumber(phoneNumber: phoneNumber, view: self) { status in
            if status == true {
                let otpVC = self.storyboard?.instantiateViewController(withIdentifier: "OtpViewController") as! OtpViewController
                self.navigationController?.pushViewController(otpVC, animated: true)
            }
        }
    }
    

}
