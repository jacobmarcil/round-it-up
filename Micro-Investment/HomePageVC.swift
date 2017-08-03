//
//  HomePageVC.swift
//  Micro-Investment
//
//  Created by CG54 on 17-06-13.
//  Copyright © 2017 ETS. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseStorage
import FirebaseAuth

class HomePageVC: UIViewController {
    
    var ref:DatabaseReference!
    var refHandle: UInt!
    
    @IBOutlet weak var montantTotalInvesti: UILabel!
    @IBOutlet weak var montantAujourdhui: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    override func viewWillAppear(_ animated: Bool) {

        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
           // self.email.text = value?["email"] as? String ?? ""

            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

}
