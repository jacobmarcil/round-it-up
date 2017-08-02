//
//  CardScanningVC.swift
//  Micro-Investment
//
//  Created by CG54 on 17-06-14.
//  Copyright © 2017 ETS. All rights reserved.
//

import UIKit

class CardScanningVC: UIViewController, CardIOPaymentViewControllerDelegate {

    @IBOutlet weak var cardIOView: CardIOView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CardIOUtilities.preload()
        startScan()
        cardIOView.allowFreelyRotatingCardGuide = true
        cardIOView.hideCardIOLogo = true
    }

    func startScan(){
        if(CardIOUtilities.canReadCardWithCamera()){
            let scanVC: CardIOPaymentViewController = CardIOPaymentViewController.init(paymentDelegate: self)
            present(scanVC, animated: true, completion: nil)
        }
        print("start scan")

    }
    
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        
        if let info = cardInfo {
            print(info.cardholderName)
            print(info.cardNumber)
            //let str = NSString(format: "Received card info.\n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv)
            //resultLabel.text = str as String
        }
        
        paymentViewController?.dismiss(animated: true, completion: nil)
        
    }

}
