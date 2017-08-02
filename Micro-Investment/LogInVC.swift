//
//  LogInVC.swift
//  Micro-Investment
//
//  Created by CG54 on 17-06-13.
//  Copyright © 2017 ETS. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var LogInBtn: UIButton!
    
    @IBOutlet weak var emailField: UITextField!

    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
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

    @IBAction func Login(_ sender: Any) {
        if self.emailField.text == "" || self.passwordField.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    //Go to the HomeViewController if the login is sucessful
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    @IBAction func resetPassword(_ sender: Any) {
        if self.emailField.text == "" {
            let alertController = UIAlertController(title: "Oops!", message: "Please enter an email.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().sendPasswordReset(withEmail: self.emailField.text!, completion: { (error) in
                
                var title = ""
                var message = ""
                
                if error != nil {
                    title = "Error!"
                    message = (error?.localizedDescription)!
                } else {
                    title = "Success!"
                    message = "Password reset email sent."
                    self.emailField.text = ""
                }
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            })
        }
    }

    @IBAction func CreateAccountClick(_ sender: AnyObject) {
//        let appDelegate = AppDelegate.sharedAppDelegate()
//        appDelegate?.changeRootViewControllerWithIdentifier(identifier: "AfterLoginNavigationController")
        
    }
}
