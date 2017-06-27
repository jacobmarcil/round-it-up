//
//  AddBankAccountVC.swift
//  Micro-Investment
//
//  Created by CG54 on 17-06-14.
//  Copyright © 2017 ETS. All rights reserved.
//

import UIKit

class AddBankAccountVC: UIViewController {

    @IBOutlet weak var desjardinsBtn: UIButton!
    @IBOutlet weak var bmoBtn: UIButton!
    @IBOutlet weak var scotiaBtn: UIButton!
    @IBOutlet weak var tdBtn: UIButton!
    @IBOutlet weak var otherBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        desjardinsBtn.layer.cornerRadius = 5
        desjardinsBtn.layer.borderWidth = 1
        desjardinsBtn.layer.borderColor = UIColor.white.cgColor
        
        bmoBtn.layer.cornerRadius = 5
        bmoBtn.layer.borderWidth = 1
        bmoBtn.layer.borderColor = UIColor.white.cgColor
        
        scotiaBtn.layer.cornerRadius = 5
        scotiaBtn.layer.borderWidth = 1
        scotiaBtn.layer.borderColor = UIColor.white.cgColor
        
        tdBtn.layer.cornerRadius = 5
        tdBtn.layer.borderWidth = 1
        tdBtn.layer.borderColor = UIColor.white.cgColor

        otherBtn.layer.cornerRadius = 5
        otherBtn.layer.borderWidth = 1
        otherBtn.layer.borderColor = UIColor.white.cgColor

    }
    
    

}
