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
        transactionTableView.reloadData()
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
        transactionTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 33//self.listeTransactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = self.transactionTableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as? TransactionTableViewCell
        var i: Int = 0
        for tr in self.listeTransactions{
            if indexPath.row == i {
                cell?.montant.text = tr["montant"]
                cell?.date.text = tr["date"]
                cell?.descriptionTransaction.text = tr["description"]
                return cell!
            }
            i += 1
        }
            return cell!
        }
    
    }
    

