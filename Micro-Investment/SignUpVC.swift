//
//  SignUpVC.swift
//  Micro-Investment
//
//  Created by CG54 on 17-06-13.
//  Copyright © 2017 ETS. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignUpVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTB: UITextField!
    @IBOutlet weak var lastNameTB: UITextField!
    @IBOutlet weak var emailTB: UITextField!
    @IBOutlet weak var passwordTB: UITextField!
    
    @IBOutlet weak var nextStepBtn: UIButton!
    @IBOutlet weak var dateTextField: UITextField!
    var refUsers: DatabaseReference!
    var refBanque: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refUsers = Database.database().reference().child("users");
        refBanque = Database.database().reference().child("banque");
        nextStepBtn.layer.cornerRadius = 5
        nextStepBtn.layer.borderWidth = 1
        nextStepBtn.layer.borderColor = UIColor.white.cgColor
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpVC.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        self.firstNameTB.delegate = self;
        self.lastNameTB.delegate = self;
        self.emailTB.delegate = self;
        self.passwordTB.delegate = self;
        

        
        
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
    
    @IBAction func createAccountAction(_ sender: Any) {

        
        if emailTB.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else if (firstNameTB.text == "" || lastNameTB.text == "" || dateTextField.text == "" ){
            let alertController = UIAlertController(title: "Error", message: "Please enter your profile informations", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        }else {
            Auth.auth().createUser(withEmail: emailTB.text!, password: passwordTB.text!) { (user, error) in
                
                if error == nil {
                    print("You have successfully signed up")
                    //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "bankAccount")
                    self.present(vc!, animated: true, completion: nil)
                    self.addUsersInfo()
                    
                } else {
                    
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
        }
       
    }
    
    func addUsersInfo(){

        let uid = Auth.auth().currentUser?.uid
        //creating artist with the given values
        let users = [
                      "prenom": firstNameTB.text! as String,
                      "nom": lastNameTB.text! as String,
                      "datedenaissance": dateTextField.text! as String,
                      "email":emailTB.text! as String,
                      "password":passwordTB.text! as String
        ]
         refUsers.child(uid!).setValue(users)

        //Decocher pour ajouter des cartes au compte de la banque + modifier les numero dans la function
        addUsersInfoBanqueTest()
    }

    func addUsersInfoBanqueTest(){
        let uid = Auth.auth().currentUser?.uid
        
        let carte1 = [
            "numero" : "4540 1100 3984 9285" as String,
            "dateExp": "12/19" as String,
            "cvv" : "746" as String,
            "type" : "Carte de crédit",
            "compagnie": "Desjardins",
            "privilege": "Visa Or"
        ]
        
        
        let carte2 = [
            "numero" : "4510 3342 6274 7356" as String,
            "dateExp": "02/21" as String,
            "cvv" : "536" as String,
            "type" : "Carte de débit",
            "compagnie": "Banque Nationale",
            "privilege": "Banque Nationale"
            
        ]
        /*
        let carte3 = [
            "numero" : "4510 8475 8826 9987" as String,
            "dateExp": "05/23" as String,
            "cvv" : "172" as String,
            "type" : "Carte de débit",
            "compagnie": "Banque de Montréal",
            "privilege": "BMO"
            
        ]
        let carte3 = [
            "numero" : "4543 7466 8374 6374" as String,
            "dateExp": "03/18" as String,
            "cvv" : "986" as String,
            "type" : "Carte de débit",
            "compagnie": "Scotiabank",
            "privilege": "Scotiabank"
            
        ]
         let carte5 = [
         "numero" : "4543 7466 8374 6374" as String,
         "dateExp": "03/18" as String,
         "cvv" : "986" as String,
         "type" : "Carte de crédit",
         "compagnie": "TD Canada Trust",
         "privilege": "TD"
         
         ]
 */
        
        refBanque.child(uid!).child("0").setValue(carte1)
        refBanque.child(uid!).child("1").setValue(carte2)
        
        /*
        refBanque.child(uid!).child("0").setValue(carte3)
        refBanque.child(uid!).child("1").setValue(carte4)
        refBanque.child(uid!).child("0").setValue(carte5)
         */
    }
    
    @IBAction func test(_ sender: UITextField) {
        let datePickerView: UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(SignUpVC.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func datePickerValueChanged(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        dateTextField.text = dateFormatter.string(from: sender.date)
        
    }
    

}
