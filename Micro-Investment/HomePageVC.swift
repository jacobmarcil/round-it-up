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
    @IBOutlet weak var nom: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var birthDate: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    override func viewWillAppear(_ animated: Bool) {

        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            self.email.text = value?["email"] as? String ?? ""
            self.nom.text = value?["prenom"] as? String ?? ""
            self.birthDate.text = value?["datedenaissance"] as? String ?? ""
            self.lastName.text = value?["nom"] as? String ?? ""
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
