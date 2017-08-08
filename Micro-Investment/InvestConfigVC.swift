//
//  InvestConfigVC.swift
//  Micro-Investment
//
//  Created by CG54 on 17-08-06.
//  Copyright © 2017 ETS. All rights reserved.
//

import UIKit

class InvestConfigVC: UIViewController {

    @IBOutlet weak var switchDollar: UISwitch!
    @IBOutlet weak var switchPourc: UISwitch!
    
    @IBOutlet weak var nextBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        nextBtn.layer.cornerRadius = 5
        nextBtn.layer.borderWidth = 1
        nextBtn.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func changeDollar(_ sender: Any) {
        if self.switchDollar.isOn{
            self.switchPourc.isOn = false
        }
        else{
            self.switchPourc.isOn = true
        }
    }
    
    @IBAction func changePourc(_ sender: Any) {
        if self.switchPourc.isOn{
            self.switchDollar.isOn = false
        }
        else{
            self.switchDollar.isOn = true
        }
    }
}
