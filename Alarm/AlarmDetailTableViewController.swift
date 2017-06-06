//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Nick Reichard on 6/5/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    // MARK: - Properties
    
    var alarm: Alarm? {
        didSet {
            if isViewLoaded {
                updateViews()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        guard let alarm = alarm,
            let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight,
            isViewLoaded else {
                enableButton.isHidden = true
                return
        }
        datePicker.setDate(Date(timeInterval: alarm.fireTimeFromMidnight, since: thisMorningAtMidnight), animated: false)
        titleTextField.text = alarm.name
        
        enableButton.isHidden = false
        if enableButton.isHidden {
            enableButton.setTitle("Disable", for: UIControlState())
            enableButton.setTitleColor(.white, for: UIControlState())
            enableButton.backgroundColor = UIColor.red
        } else {
            enableButton.setTitle("Enable", for: UIControlState())
            enableButton.setTitleColor(.blue, for: UIControlState())
            enableButton.backgroundColor = UIColor.gray
        }
        self.title = alarm.name
    }
    
    // MARK: - Actions
    
    @IBAction func enableButtonTapped(_ sender: Any) {
        guard let alarm = alarm else { return }
        AlarmController.shared.toggleEnabled(for: alarm)
        if alarm.enabled {
        }
     
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        tappedSaveButton()
    }
    
    func tappedSaveButton() {
        guard let title = titleTextField.text,
            let thisMorningAtMidNight = DateHelper.thisMorningAtMidnight else { return }
        let timeIntervalSinceMidnight = datePicker.date.timeIntervalSince(thisMorningAtMidNight)
        if let alarm = alarm {
            AlarmController.shared.updateAlarm(alarm: alarm, fireTimeFromMidnight: timeIntervalSinceMidnight, name: title)
        } else {
            let alarm = AlarmController.shared.addAlarm(fireTimeFromMidnight: timeIntervalSinceMidnight, name: title)
            self.alarm = alarm
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
}
