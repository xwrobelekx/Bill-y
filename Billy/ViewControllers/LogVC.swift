//
//  LogVC.swift
//  Billy
//
//  Created by Kamil Wrobel on 7/29/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import UIKit


/*
 
 Version 2.0
 
 */

class LogVC: UIViewController, UITextFieldDelegate {
    
    //MARK: - Properties
    let datePicker = UIDatePicker()
    
    
    //MARK: - Outlets
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!

    
    //MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        dateTextField.inputView = datePicker
        amountTextField.delegate = self
        categoryTextField.delegate = self
    }
    
    //MARK: - TextField Delegate Methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        datePicker.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)

    }
    
    
    //MARK: - Actions
    @IBAction func doneButtonPRessed(sender: UIButton){
        // save the log
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed( sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }


}
