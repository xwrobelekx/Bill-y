//
//  MainViewTableViewCell.swift
//  Billy
//
//  Created by Kamil Wrobel on 12/31/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

protocol MainBillCustomCellDelegate: class{
    func billIsPaidToggle(cell: MainViewTableViewCell)
}

class MainViewTableViewCell: UITableViewCell {
    
    
    //MARK: - Properties
    var bill: NewBill? {
        didSet {
            updateViews()
        }
    }
    var cellDelegate: MainBillCustomCellDelegate?
    
    //MARK: - Outlets
    @IBOutlet weak var billTitle: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var isPaidButtonOutlet: UIButton!
    
    
    //MARK: - LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    //MARK: - Actions
    @IBAction func isPaidButtonPressed(_ sender: Any) {
        cellDelegate?.billIsPaidToggle(cell: self)
        updateViews()
    }
    
    
    //MARK: - Helper Methods
    func updateViews(){
        guard let bill = bill else {return}
        billTitle.text = bill.title
        dueDateLabel.text = "\(bill.dueDate.dayAndMonthAsString())"
        
        if bill.isPaid {
            isPaidButtonOutlet.setImage(#imageLiteral(resourceName: "Paid"), for: .normal)
        } else {
            isPaidButtonOutlet.setImage(#imageLiteral(resourceName: "UnPaid"), for: .normal)
        }
    }
}
