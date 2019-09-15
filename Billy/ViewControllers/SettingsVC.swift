//
//  SettingsViewController.swift
//  Billy
//
//  Created by Kamil Wrobel on 3/9/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    //MARK: - Properties
    let timePicker = UIDatePicker()
    let daysDelayPicker = UIPickerView()
    
    
    //MARK: - Outlets
    @IBOutlet weak var notificationDaysDelayTextField: UITextField!
    @IBOutlet weak var notificationTimeTextField: UITextField!
    @IBOutlet weak var notifyTwoDayesBeforeSwitch: UISwitch!
    @IBOutlet weak var notifyOnDueDateSwitch: UISwitch!
    @IBOutlet weak var mainView: UIView!
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        notificationTimeTextField.inputView = timePicker
        daysDelayPicker.delegate = self
        daysDelayPicker.dataSource = self
        daysDelayPicker.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        notificationDaysDelayTextField.inputView = daysDelayPicker
        notificationDaysDelayTextField.text = "\(SettingController.shared.setting.dayDelay)"
        notificationTimeTextField.text = "\(SettingController.shared.setting.notificationTime?.timeAsStringWithAMSymbol() ?? "8:30 AM")"
        //        print("🍌 \(SettingController.shared.setting.notificationTime?.timeAsStringWithAMSymbol())")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        SettingController.shared.saveSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        SettingController.shared.loadSettings()
        //        print("Ⓜ️ \(SettingController.shared.setting.notificationTime?.timeAsStringWithAMSymbol())")
        notifyTwoDayesBeforeSwitch.setOn(SettingController.shared.setting.notifyTwoDaysBefore, animated: true)
        notifyOnDueDateSwitch.setOn(SettingController.shared.setting.notifyOnDay, animated: true)
    }
    
    
    //MARK: - Actions
    @IBAction func resetButtonPressed(_ sender: Any) {
        hapticFeedback()
        SettingController.shared.setting.dayDelay = 5
        SettingController.shared.setting.notificationTime = Date(timeIntervalSince1970: 48640)
        notificationTimeTextField.text = "\(SettingController.shared.setting.notificationTime!.timeAsStringWithAMSymbol())"
        notificationDaysDelayTextField.text = "\(SettingController.shared.setting.dayDelay)"
        SettingController.shared.setting.notifyOnDay = true
        SettingController.shared.setting.notifyTwoDaysBefore = true
        notifyTwoDayesBeforeSwitch.setOn(SettingController.shared.setting.notifyTwoDaysBefore, animated: true)
        notifyOnDueDateSwitch.setOn(SettingController.shared.setting.notifyOnDay, animated: true)
        
    }
    
    @IBAction func notifyTwoDaysBeforeSwitchPressed(_ sender: UISwitch){
        SettingController.shared.setting.notifyTwoDaysBefore = sender.isOn
        SettingController.shared.checkNotificationStates()
    }
    
    @IBAction func notifyOnDueDaySwitchPressed(_ sender: UISwitch){
        SettingController.shared.setting.notifyOnDay = sender.isOn
        SettingController.shared.checkNotificationStates()
    }
    
    
    //MARK: - UIPicker Delegate methods
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DayAndTimeDelay.shared.dayDelay.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(DayAndTimeDelay.shared.dayDelay[row])"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        notificationDaysDelayTextField.resignFirstResponder()
        notificationTimeTextField.resignFirstResponder()
        return true
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == daysDelayPicker {
            SettingController.shared.setting.dayDelay = DayAndTimeDelay.shared.dayDelay[row]
            notificationDaysDelayTextField.text = "\(SettingController.shared.setting.dayDelay)"
        } else {
            print("no picker found")
        }
    }
    
    @objc func datePickerValueChanged() {
        SettingController.shared.setting.notificationTime = timePicker.date
        notificationTimeTextField.text = "\(timePicker.date.timeAsStringWithAMSymbol())"
        //        print("🥕 \(SettingController.shared.setting.notificationTime?.timeAsStringWithAMSymbol())")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //  print("\(SettingController.shared.notificationTime.description)")
    
}
