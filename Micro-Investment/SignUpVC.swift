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
    let uid = Auth.auth().currentUser?.uid
    var montantInvestiTotal: Double = 0.0
    var montantInvestiTotalShow: String = "0.0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
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
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.barTintColor = view.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        navigationItem.title = "Round It Up!"
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
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
                    self.navigationController?.pushViewController(vc!, animated: true)
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

        
        //creating artist with the given values
        let users = [
                      "prenom": firstNameTB.text! as String,
                      "nom": lastNameTB.text! as String,
                      "datedenaissance": dateTextField.text! as String,
                      "email":emailTB.text! as String,
                      "password":passwordTB.text! as String,
                      "montantTotalInvesti": "0",
                      "montantAujourdhui": "0"
        ]
         refUsers.child(uid!).setValue(users)

        //Decocher pour ajouter des cartes au compte de la banque + modifier les numero dans la function
        addUsersInfoBanqueTest()
    }

    func addUsersInfoBanqueTest(){
        let uid = Auth.auth().currentUser?.uid
        let unecarte = [
            "numero" : "4540 1100 3984 9285" as String,
            "dateExp": "12/19" as String,
            "cvv" : "746" as String,
            "type" : "Carte de crédit",
            "compagnie": "Desjardins",
            "privilege": "Visa Or"
        ]
        
        
        let deuxiemecarte = [
            "numero" : "4510 3342 6274 7356" as String,
            "dateExp": "02/21" as String,
            "cvv" : "536" as String,
            "type" : "Carte de débit",
            "compagnie": "Banque Nationale",
            "privilege": "Banque Nationale"
            
        ]
        
 
        refBanque.child(uid!).child("0").setValue(deuxiemecarte)
        for i in 0 ..< 10 {
            
            refBanque.child(uid!).child("0").child("transactions").child(String(i)).setValue(newTransaction())
            
        }
        refBanque.child(uid!).child("1").setValue(deuxiemecarte)
        for i in 0 ..< 11 {
            
            refBanque.child(uid!).child("1").child("transactions").child(String(i)).setValue(newTransaction())
            
        }
        refBanque.child(uid!).child("2").setValue(deuxiemecarte)
        for i in 0 ..< 12 {
            
            refBanque.child(uid!).child("2").child("transactions").child(String(i)).setValue(newTransaction())
            
        }

    }
    
    func fetchDatabase(){
        
        refUsers.child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            self.montantInvestiTotalShow = value?["montantTotalInvesti"] as? String ?? ""
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func montantInvesti(montant: String){
        fetchDatabase()
        montantInvestiTotal = Double(montantInvestiTotal) + Double(montant)!
        refUsers.child(uid!).child("montantTotalInvesti").setValue(montantInvestiTotal)
        
    }
    
    func newTransaction() -> [String: String]{
        
        let montant = Double(arc4random_uniform(30001))/100.0
        var dateJour = Int(arc4random_uniform(30))
        var dateMois = Int(arc4random_uniform(12))
        
        let aFloat: Float = Float(1-montant.truncatingRemainder(dividingBy: 1))
        
        let roundUp: String = String(format: "%.2f", aFloat) // "1.0"
        
        if (dateJour == 0) {
            dateJour = 1
        }
        if (dateMois == 0) {
            dateMois = 1
        }
        let dateAnnee = 2017
        let date = String(dateJour) + "-" + String(dateMois) + "-" + String(dateAnnee)
        let transactionUn = [
            "date": date,
            "description": "Café Oui Mais Non",
            "montant": String(montant),
            "roundUp": String(roundUp)
        ]
        montantInvesti(montant: roundUp)
        
        return transactionUn as! [String : String]
    
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
    
    func generateRandomDate(daysBack: Int)-> Date?{
        let day = arc4random_uniform(UInt32(daysBack))+1
        let hour = arc4random_uniform(23)
        let minute = arc4random_uniform(59)
        
        let today = Date(timeIntervalSinceNow: 0)
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.day = Int(day - 1)
        offsetComponents.hour = Int(hour)
        offsetComponents.minute = Int(minute)
        
        let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) )
        return randomDate
    }
    

}
