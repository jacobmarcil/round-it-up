//
//  ChooseAccountVC.swift
//  Micro-Investment
//
//  Created by CG54 on 17-06-15.
//  Copyright © 2017 ETS. All rights reserved.
//

import UIKit

class ChooseAccountVC: UIViewController {

    @IBOutlet weak var btnDebit: UIButton!
    @IBOutlet weak var btnCredit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnDebit.layer.cornerRadius = 5
        btnDebit.layer.borderWidth = 1
        btnDebit.layer.borderColor = UIColor.white.cgColor
        
        btnCredit.layer.cornerRadius = 5
        btnCredit.layer.borderWidth = 1
        btnCredit.layer.borderColor = UIColor.white.cgColor
    }

}
