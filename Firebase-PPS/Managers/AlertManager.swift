//
//  AlertManager.swift
//  Firebase-PPS
//
//  Created by Sarath P on 28/02/22.
//

import UIKit

class AlertManager {
    
    static let sharedInstance = AlertManager()
    
    private init(){
        
    }
    
    func alert(view: UIViewController, messages: String){
        let alertController = UIAlertController(title: "" , message: messages, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        view.present(alertController, animated: true, completion: nil)
    }
}
