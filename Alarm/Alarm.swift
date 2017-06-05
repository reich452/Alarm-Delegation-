//
//  Alarm.swift
//  Alarm
//
//  Created by Nick Reichard on 6/5/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import Foundation

class Alarm {
    
    // MARK: - Properties 
    
    var fireTimeFromMidnight: TimeInterval
    var name: String
    var enabled: Bool
    let uuid: String
    
    // MARK: - Computed properites 
    
    var fireDate: Date? {
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return nil }
        let fireTimeInMinutes = Int(fireTimeFromMidnight / 60)
        let fireTimeInSeconds = TimeInterval(fireTimeInMinutes * 60)
        let fireDateFromThisMorning = Date(timeInterval: fireTimeInSeconds, since: thisMorningAtMidnight)
        return fireDateFromThisMorning
    }
    
    var fireTimeAsString: String {
        let fireTimeFromMidnight = Int(self.fireTimeFromMidnight)
        var hours = fireTimeFromMidnight/60/60
        let minutes = (fireTimeFromMidnight - (hours*60*60))/60
        if hours >= 13 {
            return String(format: "%2d:%02d PM", arguments: [hours - 12, minutes])
        } else if hours >= 12 {
            return String(format: "%2d:%02d PM", arguments: [hours, minutes])
        } else {
            if hours == 0 {
                hours = 12
            }
            return String(format: "%2d:%02d AM", arguments: [hours, minutes])
        }
    }
    
    
    init(fireTimeFromMidnight: TimeInterval, name: String, enabled: Bool = false , uuid: String = UUID().uuidString) {
        self.fireTimeFromMidnight = fireTimeFromMidnight
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
    }
}

// MARK: - Equatable 

func ==(lsh: Alarm, rhs: Alarm) -> Bool {
    return lsh === rhs
}
