//
//  ChooseAccountVC.swift
//  Micro-Investment
//
//  Created by CG54 on 17-06-15.
//  Copyright © 2017 ETS. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth

class ChooseAccountVC: UIViewController, CardIOPaymentViewControllerDelegate {

    var ref:DatabaseReference!
    var refUsers: DatabaseReference!
    var refBanque: DatabaseReference!
    var numberOfCard: Int!
    var numberOfCardString: String!
    var cardType: String!
    @IBOutlet weak var btnDebit: UIButton!
    
    @IBOutlet weak var cardTyp: UILabel!
    @IBOutlet weak var cardNumber: UILabel!
    
    @IBOutlet weak var cardNumberDebit: UILabel!
    @IBOutlet weak var debitBtn: UIButton!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    static func prepareController(originController: UIViewController) -> ChooseAccountVC? {
    
        if let chooseAccountVC = originController.storyboard?.instantiateViewController(withIdentifier: "ChooseAccountVC") as? ChooseAccountVC{
            return chooseAccountVC
        }
        else{
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        refUsers = Database.database().reference().child("users");
        refBanque = Database.database().reference().child("banque");
        btnDebit.layer.cornerRadius = 5
        btnDebit.layer.borderWidth = 1
        btnDebit.layer.borderColor = UIColor.white.cgColor
        
        nextBtn.layer.cornerRadius = 5
        nextBtn.layer.borderWidth = 1
        nextBtn.layer.borderColor = UIColor.white.cgColor
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        CardIOUtilities.preload()
        startScan()
    }
    
    override func viewWillAppear(_ animated: Bool) {
 
        numberOfCards()
    }
    
    func startScan(){
        if(CardIOUtilities.canReadCardWithCamera()){
            let scanVC: CardIOPaymentViewController = CardIOPaymentViewController.init(paymentDelegate: self)
            present(scanVC, animated: true, completion: nil)
        }
    }
    
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        
        if let info = cardInfo {
            if info.cardType.hashValue == 5{
                self.cardType = "Mastercard"
            } else if info.cardType.hashValue ==  4{
                self.cardType = "Visa"
            }
            addCardsToAccount(numero: info.cardNumber, dateExpYear: info.expiryYear.description, dateExpMonth: info.expiryMonth.description, cvv: info.cvv, type: self.cardType)
            
            self.cardNumber.text = info.redactedCardNumber

        }
        
        paymentViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    
    func numberOfCards(){
        let userID = Auth.auth().currentUser?.uid
        ref.child("banque").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                
                for snap in snapshots
                {
                   self.numberOfCard = snapshots.count
                    self.numberOfCardString = String(self.numberOfCard)
                }
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func addCardsToAccount(numero: String, dateExpYear: String, dateExpMonth: String, cvv: String, type: String ){
        let uid = Auth.auth().currentUser?.uid
        
        let unecarte = [
            "numero" : numero,
            "dateExpYear": dateExpYear,
            "dateExpMonth": dateExpMonth,
            "cvv" : cvv,
            "type" : type
        ]

        
        refBanque.child(uid!).child(numberOfCardString).setValue(unecarte)
    
    }
}
