//
//  MainVC.swift
//  Billy
//
//  Created by Kamil Wrobel on 12/27/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit
import UserNotifications

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MainBillCustomCellDelegate {
    
    //MARK: - Properties
    var pastDueBills = [NewBill]()
    var dueThisMonth = [NewBill]()
    var paidBills = [NewBill]()
    
    
    //MARK: - Outlets
    @IBOutlet weak var curentDateLabel: UILabel!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        curentDateLabel.text = Date().asStringLonger()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        pastDueBills = BillsController.shared.filterBills(by: .isPastDue).sorted(by: { (first, second) -> Bool in
            first.dueDate < second.dueDate
        })
        dueThisMonth = BillsController.shared.filterBills(by: .isDueThisMonth).sorted(by: { (first, second) -> Bool in
            first.dueDate < second.dueDate
        })
        mainTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: NotificationController.shared.nonitifcationIdentyfiers)
        center.removeDeliveredNotifications(withIdentifiers: NotificationController.shared.nonitifcationIdentyfiers)
        NotificationController.shared.nonitifcationIdentyfiers.removeAll()
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIButton){
        addButton.hapticFeedback()
    }
    
    
    //MARK: - Table View Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = CustomViewWithRoundedCorners()
        view.backgroundColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        let label = UILabel()
        label.textColor = .white
        switch section {
        case 0 :
            if pastDueBills.count == 0 && dueThisMonth.count == 0 {
                label.font = UIFont(name: "Marker Felt", size: 17)
                label.text = "No bills due this month."
            } else if pastDueBills.count >= 1 {
                label.font = UIFont(name: "Marker Felt", size: 17)

                label.text = "Past due bills:"
            } else {
                label.text = ""
                view.backgroundColor = .clear
            }
        case 1:
            if dueThisMonth.count == 0 {
                label.text = ""
            } else {
                label.font = UIFont(name: "Marker Felt", size: 17)
                label.text = "Bills due within a month:"
            }
        default:
            label.text = ""
        }
        label.frame = CGRect(x: 15, y: 5, width: 200, height: 25)
        view.addSubview(label)
        return view
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return pastDueBills.count
        case 1:
            return dueThisMonth.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell55", for: indexPath) as? MainViewTableViewCell else {return UITableViewCell()}
        cell.cellDelegate = self
        switch indexPath.section {
        case 0:
            cell.bill = pastDueBills[indexPath.row]
        case 1:
            cell.bill = dueThisMonth[indexPath.row]
        default:
            print("No bills in main view cell")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        //it takes them froll al of the bill insted of "due next week"
        switch indexPath.section {
        case 0:
            let bill = pastDueBills[indexPath.row]
            BillsController.shared.delete(bill: bill)
            pastDueBills.remove(at: indexPath.row)
            
        case 1:
            let bill = dueThisMonth[indexPath.row]
            BillsController.shared.delete(bill: bill)
            dueThisMonth.remove(at: indexPath.row)
            
        default : print("Error")
        }
        hapticFeedback()
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let bill = pastDueBills[indexPath.row]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let detailVC = storyboard.instantiateViewController(withIdentifier: "detailVC") as? BillDetailVC else {return}
            detailVC.bill = bill
            present(detailVC, animated: true)
            
        case 1:
            let bill = dueThisMonth[indexPath.row]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let detailVC = storyboard.instantiateViewController(withIdentifier: "detailVC") as? BillDetailVC else {return}
            detailVC.bill = bill
            present(detailVC, animated: true)
            
        default : print("Error")
        }
    }
    
    
    //MARK: - Custom cell protocol conformance
    func billIsPaidToggle(cell: MainViewTableViewCell) {
        guard let bill = cell.bill else {return}
        guard let indexOfBill = BillsController.shared.bills.index(of: bill) else {return}
        BillsController.shared.bills[indexOfBill].isPaid.toggle()
        BillsController.shared.markBillPaid(bill: bill)
        
        
//        if bill.isPaid == true {
//            for identyfier in bill.notificationIdentyfier {
//                NotificationController.shared.nonitifcationIdentyfiers.append(identyfier)
//                print("‼️ notification identyfiers count after toggl add: \(NotificationController.shared.nonitifcationIdentyfiers.count)")
//            }
//        } else {
//            for billID in NotificationController.shared.nonitifcationIdentyfiers {
//                for identyfier in bill.notificationIdentyfier {
//                    if billID == identyfier {
//                        if let indexOfNotificationID = NotificationController.shared.nonitifcationIdentyfiers.index(of: billID) {
//                            NotificationController.shared.nonitifcationIdentyfiers.remove(at: indexOfNotificationID)
//                        }
//                        print("❎ notification identyfiers count after toggle remove: \(NotificationController.shared.nonitifcationIdentyfiers.count)")
//                    }
//                }
//
//            }
//
//        }
        
    }
    
    
    func modified(indexPath: IndexPath) -> Int {
        return (indexPath.section * 2) + (indexPath.row)
    }


}





