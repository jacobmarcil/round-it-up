//
//  LoadingVC.swift
//  Micro-Investment
//
//  Created by CG54 on 17-08-05.
//  Copyright © 2017 ETS. All rights reserved.
//

import UIKit

class LoadingVC: UIViewController {

    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loading.startAnimating()
        self.navigationController?.navigationBar.isHidden = true
        
        let delay = 3.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home"){
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}
