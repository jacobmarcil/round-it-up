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
import Charts

class HomePageVC: UIViewController {
    
    var ref:DatabaseReference!
    var refHandle: UInt!
    @IBOutlet weak var montantTotalInvesti: UILabel!
    @IBOutlet weak var montantAujourdhui: UILabel!
    
    @IBOutlet weak var graphView: BarChartView!
    @IBOutlet weak var montantTotal: UILabel!
    
    var refBanque: DatabaseReference!
    var listeTransacs: [[String:String]] = []
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refBanque = Database.database().reference().child("banque")
        
        ref = Database.database().reference()
        graphView.leftAxis.drawAxisLineEnabled = false
        graphView.leftAxis.drawGridLinesEnabled = false
        graphView.leftAxis.drawLabelsEnabled = false
        
        graphView.rightAxis.drawAxisLineEnabled = false
        graphView.rightAxis.drawGridLinesEnabled=false
        graphView.rightAxis.drawLabelsEnabled = false
        
        graphView.xAxis.drawAxisLineEnabled=false
        graphView.xAxis.drawLabelsEnabled=false
        
        graphView.drawGridBackgroundEnabled = false
        graphView.drawBordersEnabled = false
        
        graphView.chartDescription?.text = ""
    
        updateChart()
        numberOfCards()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {

        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            self.montantTotal.text = value?["montantTotalInvesti"] as? String ?? "15.39"
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func updateChart(){
        var dataEntries: [BarChartDataEntry] = []
        let values = [11,15,13,16,7,5,10,9,13,12,11,15,13,16,7,5,10,9,13,12,11,15,13,16,7,5,10,9,13,12]
        for i in 0..<values.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "$ arrondis")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartDataSet.setColor(NSUIColor.white)
        graphView.data = chartData
    }

    @IBAction func pushVC(_ sender: Any) {
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "Transaction") as? TransactionVC{
            vc.listeTransactions = self.listeTransacs
            self.present(vc, animated: true, completion: nil)
        }

    }
    
    func numberOfCards(){
        if let userID = Auth.auth().currentUser?.uid{
            refBanque.child(userID).child("1").child("transactions").observeSingleEvent(of: .value, with: { (snapshot) in
                
                for transaction in (snapshot.value as? [[String:String]])! {
                    self.listeTransacs.append(transaction)
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
}
