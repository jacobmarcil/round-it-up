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
    @IBOutlet weak var btnDebit: UIButton!
    
    @IBOutlet weak var cardTyp: UILabel!
    @IBOutlet weak var cardNumber: UILabel!
    
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
        btnDebit.layer.cornerRadius = 5
        btnDebit.layer.borderWidth = 1
        btnDebit.layer.borderColor = UIColor.white.cgColor
        
        self.navigationController?.navigationBar.isHidden = false
        CardIOUtilities.preload()
        startScan()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        var count = 0;
//        let userID = Auth.auth().currentUser?.uid
//        ref.child("banque").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
//            
//            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
//                
//                for snap in snapshots
//                {
//                    if(count==0){
//                        self.carteUn.text = snap.childSnapshot(forPath: "numero").value! as! String
//                        self.typeUn.text = snap.childSnapshot(forPath: "type").value! as! String
//                        self.privilegeUn.text = snap.childSnapshot(forPath: "privilege").value! as! String
//                        count = count + 1
//                    }
//                    if(count==1){
//                        self.carteDeux.text = snap.childSnapshot(forPath: "numero").value! as! String
//                        self.type.text = snap.childSnapshot(forPath: "type").value! as! String
//                        self.privilege.text = snap.childSnapshot(forPath: "privilege").value! as! String
//                    }
//                }
//                count = 0;
//            }
//            
//        }) { (error) in
//            print(error.localizedDescription)
//        }
        
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
            
            self.cardNumber.text = info.redactedCardNumber
            
            if info.cardType.hashValue == 5{
                self.cardTyp.text = "Mastercard"
            } else if info.cardType.hashValue ==  4{
                 self.cardTyp.text = "Visa"
            }

        }
        
        paymentViewController?.dismiss(animated: true, completion: nil)
        
    }
}
