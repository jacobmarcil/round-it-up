//
//  TransactionTableViewCell.swift
//  Micro-Investment
//
//  Created by CG54 on 17-08-03.
//  Copyright © 2017 ETS. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var montant: UILabel!
    @IBOutlet weak var descriptionTransaction: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell (date: String, description: String, montant: String){
        
        self.date.text = date
        self.descriptionTransaction.text = description
        self.montant.text = montant
        
    }
    

}
