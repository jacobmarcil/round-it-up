//
//  LogInVC.swift
//  Micro-Investment
//
//  Created by CG54 on 17-06-13.
//  Copyright © 2017 ETS. All rights reserved.
//

import UIKit

class LogInVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var LogInBtn: UIButton!
    
    @IBOutlet weak var emailField: UITextField!

    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        LogInBtn.layer.cornerRadius = 5
        LogInBtn.layer.borderWidth = 1
        LogInBtn.layer.borderColor = UIColor.white.cgColor
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LogInVC.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        self.emailField.delegate = self;
        self.passwordField.delegate = self;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
    @IBAction func CreateAccountClick(_ sender: AnyObject) {
//        let appDelegate = AppDelegate.sharedAppDelegate()
//        appDelegate?.changeRootViewControllerWithIdentifier(identifier: "AfterLoginNavigationController")
        
    }
}
