//
//  TransactionVC.swift
//  Micro-Investment
//
//  Created by CG54 on 17-08-03.
//  Copyright © 2017 ETS. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class TransactionVC: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var transactionTableView: UITableView!
    var refBanque: DatabaseReference!
    var listeTransactions: [[String:String]] = []
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        refBanque = Database.database().reference().child("banque");
        numberOfCards()
        transactionTableView.dataSource = self
    }
    
    func numberOfCards(){
        if let userID = Auth.auth().currentUser?.uid{
            refBanque.child(userID).child("1").child("transactions").observeSingleEvent(of: .value, with: { (snapshot) in
                
                for transaction in (snapshot.value as? [[String:String]])! {
                    self.listeTransactions.append(transaction)
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listeTransactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let transactionCell = self.transactionTableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as? TransactionTableViewCell{
            
            for transaction in self.listeTransactions{
                
                transactionCell.configureCell(date: transaction["date"]!, description: transaction["description"]!, montant: transaction["montant"]!)
            }
        
            return transactionCell
        }
        else{
            return UITableViewCell()
        }
    }
    
}
