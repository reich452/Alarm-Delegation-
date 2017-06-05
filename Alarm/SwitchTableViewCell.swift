//
//  AlarmTableViewCell.swift
//  Alarm
//
//  Created by Nick Reichard on 6/5/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let alarm = alarm else { return }
        timeLable.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.isOn = alarm.enabled
    }
    
    // MARK: - Actions 
    
    @IBAction func switchValueChanged(_ sender: Any) {
        
    }
    

}
