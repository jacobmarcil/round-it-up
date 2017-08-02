//
//  HabitudeVC.swift
//  Micro-Investment
//
//  Created by CG54 on 17-08-01.
//  Copyright © 2017 ETS. All rights reserved.
//

import UIKit

class HabitudeVC: UIViewController {

    @IBOutlet weak var smokeBtn: UIButton!
    @IBOutlet weak var smokeLbl: UILabel!
    
    @IBOutlet weak var coffeeBtn: UIButton!
    @IBOutlet weak var coffeeLbl: UILabel!
    
    @IBOutlet weak var foodBtn: UIButton!
    @IBOutlet weak var foodLbl: UILabel!
    
    @IBOutlet weak var alcoolBtn: UIButton!
    @IBOutlet weak var alcoolLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        smokeBtn.layer.cornerRadius = 5
        smokeBtn.layer.borderWidth = 1
        smokeBtn.layer.borderColor = UIColor.white.cgColor
        
        coffeeBtn.layer.cornerRadius = 5
        coffeeBtn.layer.borderWidth = 1
        coffeeBtn.layer.borderColor = UIColor.white.cgColor
        
        foodBtn.layer.cornerRadius = 5
        foodBtn.layer.borderWidth = 1
        foodBtn.layer.borderColor = UIColor.white.cgColor
        
        alcoolBtn.layer.cornerRadius = 5
        alcoolBtn.layer.borderWidth = 1
        alcoolBtn.layer.borderColor = UIColor.white.cgColor

        
    }
    
    @IBAction func smokeChosen(_ sender: Any) {
        if smokeBtn.layer.borderWidth == 1{
            selectBtn(btn: smokeBtn, label: smokeLbl)
        }
        else{
            deselectBtn(btn: smokeBtn, label: smokeLbl)
        }
        
    }
    
    @IBAction func coffeeChosen(_ sender: Any) {
        if coffeeBtn.layer.borderWidth == 1{
            selectBtn(btn: coffeeBtn, label: coffeeLbl)
        }
        else{
            deselectBtn(btn: coffeeBtn, label: coffeeLbl)
        }
    }
    
    @IBAction func foodChosen(_ sender: Any) {
        if foodBtn.layer.borderWidth == 1{
            selectBtn(btn: foodBtn, label: foodLbl)
        }
        else{
            deselectBtn(btn: foodBtn, label: foodLbl)
        }
    }

    @IBAction func alcoolChosen(_ sender: Any) {
        if alcoolBtn.layer.borderWidth == 1{
            selectBtn(btn: alcoolBtn, label: alcoolLbl)
        }
        else{
            deselectBtn(btn: alcoolBtn, label: alcoolLbl)
        }
    }
    
    func selectBtn(btn: UIButton, label: UILabel){
        btn.layer.borderWidth = 4
        label.font = UIFont(name: "Avenir Next Bold", size: 15.0)
    }
    
    func deselectBtn(btn: UIButton, label: UILabel){
        btn.layer.borderWidth = 1
        label.font = UIFont(name: "Avenir Next", size: 15.0)
        
    }

}
