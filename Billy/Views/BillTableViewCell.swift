//
//  BillTableViewCell.swift
//  Billy
//
//  Created by Kamil Wrobel on 12/24/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class BillTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var billName: UILabel!
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dotLabel: UILabel!
    
    
    //MARK: - LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //MARK: - Actions
    @IBAction func billIsCompletedButtonTapped(_ sender: Any) {
    }
    
    
}
