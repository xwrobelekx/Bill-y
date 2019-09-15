//
//  MonthVC.swift
//  Billy
//
//  Created by Kamil Wrobel on 12/24/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class MonthVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, MonthCellCustomDelegate {
    
    
    //MARK: - Outlets
    @IBOutlet weak var monthCollectionView: UICollectionView!
    
    
    //MARK: - Properties
    var firstAppear = true
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        monthCollectionView.delegate = self
        monthCollectionView.dataSource = self
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = screenSize.width
        let cellHeight = screenSize.height
        let layout = monthCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        monthCollectionView.reloadData()
    }
    
    
    
    //MARK: - Collection View Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = monthCollectionView.dequeueReusableCell(withReuseIdentifier: "monthCell", for: indexPath) as? MonthCollectionViewCell else { return UICollectionViewCell() }
        cell.monthDelegate = self
        let date = Calendar.current
        let month = date.monthSymbols
        var currentMonth = month[0]
        var year = Date().yearAsInt()
        if indexPath.row < 12 {
            currentMonth = month[indexPath.row]
        } else {
            currentMonth = month[indexPath.row - 12]
            year += 1
        }
        let bills = BillsController.shared.filterBills(by: currentMonth, year: year).sorted(by: { (first, second) -> Bool in
            first.dueDate < second.dueDate
        })
        //print("\(bills.count)")
        cell.bills = bills
        cell.currentMonth = currentMonth + " " + String(year)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if firstAppear == true {
            let currentMonthIndex = Date().monthAsInt()
            let indexToScroll = IndexPath(item: currentMonthIndex - 1, section: 0)
            monthCollectionView.scrollToItem(at: indexToScroll, at: .left, animated: false)
            firstAppear = false
        }
    }
    
    
    
    //MARK: - Custom Delegate Conformance Method
    func presentDetailViewWith(bill: NewBill) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "detailVC") as? BillDetailVC else {return}
        detailVC.bill = bill
        present(detailVC, animated: true)
    }
}
