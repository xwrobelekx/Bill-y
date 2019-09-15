//
//  AddBillVC.swift
//  Billy
//
//  Created by Kamil Wrobel on 11/28/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class AddBillVC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    

    
    //MARK: - Properties
    var date: Date?
    let frequencyPicker = UIPickerView()
    var timeSelected: (hour: Int, minute: Int) = (8, 30)
    var daysDelay: Int = 0
    let datePicker = UIDatePicker()
    let yearsPicker = UIPickerView()
    var yearsToPickFrom = [Int]()
    var yearPicked = Date().yearAsInt()
    
    //MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var payemntAmoutTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var paymentFrequency: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var yearsTextField: UITextField!
    @IBOutlet weak var notificationInfoLabel: UILabel!
   
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissView))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        yearsToPickFrom = years()
        
        
        titleTextField.delegate = self
        payemntAmoutTextField.delegate = self
        dueDateTextField.delegate = self
        
        
        frequencyPicker.delegate = self
        frequencyPicker.dataSource = self
        paymentFrequency.inputView = frequencyPicker
        frequencyPicker.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        
        datePicker.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: UIControl.Event.valueChanged)
        dueDateTextField.inputView = datePicker
        
        
        yearsPicker.delegate = self
        yearsPicker.dataSource = self
        yearsTextField.inputView = yearsPicker
        yearsPicker.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        guard let notificationTime = SettingController.shared.setting.notificationTime else {return}
        
        notificationInfoLabel.text = "You will get a notification \(SettingController.shared.setting.dayDelay) days before the due date, at \(notificationTime.timeAsStringWithAMSymbol() )"
        if SettingController.shared.setting.notifyOnDay && SettingController.shared.setting.notifyTwoDaysBefore {
            // on a day and two days before
            notificationInfoLabel.text = "You will get a notification \(SettingController.shared.setting.dayDelay) days before the due date, at \(notificationTime.timeAsStringWithAMSymbol()),in adition you will be notified two days before due date, and on a due date."
            
        } else if SettingController.shared.setting.notifyOnDay == true{
            // on a day
            notificationInfoLabel.text = "You will get a notification \(SettingController.shared.setting.dayDelay) days before the due date, at \(notificationTime.timeAsStringWithAMSymbol()),in adition you will be notified on a due date."
            
            
        } else if SettingController.shared.setting.notifyTwoDaysBefore == true {
            // two days before
            notificationInfoLabel.text = "You will get a notification \(SettingController.shared.setting.dayDelay) days before the due date, at \(notificationTime.timeAsStringWithAMSymbol()),in adition you will be notified two days before due date."
            
        }
        
        if NotificationController.shared.checkNotificationPermision() == true {
            SettingController.shared.initialLaunch = false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //This checks if user has notifications enabled, if not it shows an alert and by pressing settings it takes them to iphone settings.
        //       NotificationController.shared.checkNotificationPermision()
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        
        
        if  NotificationController.shared.permissionGranted == false && launchedBefore == true {
            let alert = UIAlertController(title: "Please Enable Notifications.", message: "Its an essential feature of this app. This can be managed in settings.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (_) in
                //Acces device setting for the app
                let settingsURL = NSURL(string: UIApplication.openSettingsURLString)
                if let settings = settingsURL {
                    UIApplication.shared.openURL(settings as URL)
                }
                
            }))
            present(alert, animated: true)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        UserDefaults.standard.set(true, forKey: "launchedBefore")
    }
    
    
    
    //MARK: - TextField Delegate Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        payemntAmoutTextField.resignFirstResponder()
        dueDateTextField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        frequencyPicker.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        datePicker.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        yearsPicker.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    }
    
    
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        hapticFeedback()
        createBill()
    }
    
    
    @IBAction func cancelButonPressed(_ sender: UIButton) {
        hapticFeedback()
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Selector Methods
    @objc func datePickerValueChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        dueDateTextField.text = formatter.string(from: sender.date)
        date = sender.date
        
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date!)
        dateComponents.day! -= SettingController.shared.setting.dayDelay
        dateComponents.hour = SettingController.shared.setting.notificationTime!.hour().hour
        dateComponents.minute = SettingController.shared.setting.notificationTime!.hour().min
        let notificationDate4 = calendar.date(from: dateComponents)
        guard let notificationDate = notificationDate4 else {return}
        if notificationDate < sender.date && notificationDate > Date(){
            infoLabel.isHidden = true
            //            print("is hidden")
            //            print("🔶\(notificationDate.asString()) < \(sender.date.asString()) && \(notificationDate.asString()) > \(Date().asString())")
            
        } else {
            infoLabel.isHidden = false
            //            print(" not hidden ")
        }
    }
    
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Bill Frequancy Picker Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == frequencyPicker {
            return 1
        } else if pickerView == yearsPicker {
            return 1
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == frequencyPicker {
            return BillFrequency.allCases.count
        } else if pickerView == yearsPicker {
            return yearsToPickFrom.count
        } else {
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == frequencyPicker {
            return "\(BillFrequency.allCases[row].rawValue)"
        } else if pickerView == yearsPicker {
            return "Continue till the end of \(yearsToPickFrom[row])."
        } else {
            return "0"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == frequencyPicker {
            let selectedOption = BillFrequency.allCases[row]
            paymentFrequency.text = selectedOption.rawValue
        } else if pickerView == yearsPicker {
            yearPicked = yearsToPickFrom[row]
            yearsTextField.text = "Continue till the end of \(yearPicked)."
           
        } else {
            print("no picker found")
        }
    }
    
    
    
    //MARK: - Helper Methods
    func createBill(){
        guard let title = titleTextField.text, title != "",
            let paymentAmout = payemntAmoutTextField.text, paymentAmout != "",
            let dueDate = date else {
                shake()
                return}
        hapticFeedback()
        let yearsToContinue = Int(yearsTextField.text ?? "0") ?? 0
        
        guard let payment = Double(paymentAmout) else {return}
        let bill = NewBill(title: title, dueDate: dueDate, paymentAmount: payment, notificationIdentyfier: [String](), notes: notesTextField.text, setting: SettingController.shared.setting)
        let frequency : BillFrequency? = BillFrequency(rawValue: paymentFrequency.text ?? "None")
        print("✔️🔹 Picked Years: \(yearPicked)")
        BillsController.shared.createBill2(bill: bill, frequency: frequency, howLongToContinue: yearPicked)
        dismiss(animated: true, completion: nil)
    }
    
    
    func clearTextFields(){
        titleTextField.text = ""
        payemntAmoutTextField.text = ""
        dueDateTextField.text = ""
        paymentFrequency.text = ""
        notesTextField.text = ""
    }
    
    
    func extractHourAndMinute(from time: String) -> (hour: Int, minute: Int){
        let colon = time.index(of: ":") ?? time.endIndex
        let hour = Int(time[..<colon])!
        let minute = Int(time[time.index(after: colon)...]) ?? 0
        return (hour, minute)
    }
    
    func confirmattionPopUpWith(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true)
    }
    
    
    func years() -> [Int] {
        let yearOne = Date().yearAsInt()
        var yearArray = [Int]()
        yearArray.append(yearOne)
        yearArray.append(yearOne + 1)
        yearArray.append(yearOne + 2)
        yearArray.append(yearOne + 3)
        return yearArray
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
