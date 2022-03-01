//
//  OtpViewController.swift
//  Firebase-PPS
//
//  Created by Sarath P on 01/03/22.
//

import UIKit

class OtpViewController: UIViewController {

    @IBOutlet weak var otpTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func verifyButtonClicked(_ sender: Any) {
        let otp = otpTextField.text!
        FirebaseManager.sharedInstance.verifyOtp(otp: otp, view: self) { status in
            if status == true {
                let insideView = self.storyboard?.instantiateViewController(withIdentifier: "InsideViewController") as! InsideViewController
                self.navigationController?.pushViewController(insideView, animated: true)
            }
        }
    }
    
  

}
