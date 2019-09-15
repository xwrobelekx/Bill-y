//
//  BillDetailTVC.swift
//  Billy
//
//  Created by Kamil Wrobel on 7/20/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import UIKit

class BillDetailTVC: UITableViewCell {
    
    
    //MARK: - Outlets
    @IBOutlet weak var titleLAbel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var indicatorDot: UILabel!
    
    
    //MARK: - Properties
    var bill: NewBill? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: - Update
    func updateViews(){
        guard let currentBill = bill else { return}
        titleLAbel.text = currentBill.title
        dueDateLabel.text = "\(currentBill.dueDate.asString())"
        amountLabel.text = "$\(currentBill.paymentAmount)"
        if currentBill.isPaid {
            indicatorDot.textColor = #colorLiteral(red: 0, green: 0.8684847951, blue: 0.4671590328, alpha: 1)
        } else {
            indicatorDot.textColor = #colorLiteral(red: 0.8713001609, green: 0.2077551484, blue: 0.2785714269, alpha: 1)
        }
    }
}
