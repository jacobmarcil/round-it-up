//
//  CardScanningVC.swift
//  Micro-Investment
//
//  Created by CG54 on 17-06-14.
//  Copyright © 2017 ETS. All rights reserved.
//

import UIKit

class CardScanningVC: UIViewController, CardIOPaymentViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CardIOUtilities.preload()
        startScan()
    }

    
    func startScan(){
        if(CardIOUtilities.canReadCardWithCamera()){
            let scanVC: CardIOPaymentViewController = CardIOPaymentViewController.init(paymentDelegate: self)
            present(scanVC, animated: true, completion: nil)
        }
    }
    
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        paymentViewController.dismiss(animated: true, completion: nil)
    }

}
