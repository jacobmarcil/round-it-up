//
//  PortfolioVC.swift
//  Micro-Investment
//
//  Created by CG54 on 17-08-02.
//  Copyright © 2017 ETS. All rights reserved.
//

import UIKit

class PortfolioVC: UIViewController {

    @IBOutlet weak var typeOfPortfolioLbl: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var graphImg: UIImageView!
    
    @IBOutlet weak var per1: UILabel!
    @IBOutlet weak var per2: UILabel!
    @IBOutlet weak var per3: UILabel!
    @IBOutlet weak var per4: UILabel!
    @IBOutlet weak var per5: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graphImg.layer.borderWidth = 0
        graphImg.layer.borderColor = view.backgroundColor?.cgColor
        
        navigationItem.title = "Portfolio"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        pageControl.currentPage = 0
        typeOfPortfolioLbl.text = "Conservateur"
        
        nextBtn.layer.cornerRadius = 5
        nextBtn.layer.borderWidth = 1
        nextBtn.layer.borderColor = UIColor.white.cgColor
        
        
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.right:
                pageControl.currentPage = pageControl.currentPage - 1
                
                if pageControl.currentPage == typeOfPortfolio.conservateur.rawValue {
                    changeToConservateur()
                }
                else if pageControl.currentPage == typeOfPortfolio.moderate.rawValue {
                    changeToModerate()
                }
                else{
                    changeToAggressif()
                }
                
            case UISwipeGestureRecognizerDirection.left:
                pageControl.currentPage = pageControl.currentPage + 1
                if pageControl.currentPage == typeOfPortfolio.conservateur.rawValue {
                    changeToConservateur()
                }
                else if pageControl.currentPage == typeOfPortfolio.moderate.rawValue {
                    changeToModerate()
                }
                else{
                    changeToAggressif()
                }

            default:
                break
            }
        }
    }
    
    func changeToConservateur(){
        self.typeOfPortfolioLbl.text = "Conservateur"
        self.per1.text = "0"
        self.per2.text = "10"
        self.per3.text = "20"
        self.per4.text = "30"
        self.per5.text = "40"
        graphImg.image = UIImage(named: "conservateur-1")
        
    }
    
    func changeToModerate(){
        typeOfPortfolioLbl.text = "Modérer"
        self.per1.text = "20"
        self.per2.text = "20"
        self.per3.text = "20"
        self.per4.text = "20"
        self.per5.text = "20"
        graphImg.image = UIImage(named: "moderate-1")
    }
    
    func changeToAggressif(){
        typeOfPortfolioLbl.text = "Aggresif"
        self.per1.text = "40"
        self.per2.text = "30"
        self.per3.text = "20"
        self.per4.text = "10"
        self.per5.text = "0"
        graphImg.image = UIImage(named: "aggresif-1")
    }
}

enum typeOfPortfolio: Int {
    case conservateur = 0,
    moderate,
    aggresif
}

