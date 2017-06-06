//
//  AlarmController.swift
//  Alarm
//
//  Created by Nick Reichard on 6/5/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import Foundation
import UserNotifications

class AlarmController {
    
    static let shared = AlarmController()
    
    init() {
        loadFromPersistentStorage()
        
    }
    
    // MARK: - Properties
    
    var alarms: [Alarm] = []
    
    
    // MARK: - CRUD
    
    func addAlarm(fireTimeFromMidnight: TimeInterval, name: String) -> Alarm {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(alarm)
        saveToPersistentStorage()
        return alarm
    }
    
    func updateAlarm(alarm: Alarm, fireTimeFromMidnight: TimeInterval, name: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
        saveToPersistentStorage()
        
    }
    
    func delete(alarm: Alarm) {
        guard let index = alarms.index(of: alarm) else { return }
        alarms.remove(at: index)
        saveToPersistentStorage()
        
    }
    
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
    
    // MARK: - Load/Save
    
    // Archiving is similar to working with NSUserDefaults, but uses NSCoders to serialize and deserialize objects instead of our initWithDictionary and dictionaryRepresentation functions. Both are valuable to know and be comfortable with
    // NSKeyedArchiver serializes objects and saves them to a file on the device. NSKeyedUnarchiver pulls that file and deserializes the data back into our model objects.
    
    private func saveToPersistentStorage() {
        guard let filePath = type(of: self).persistentAlarmsFilePath else { return }
        NSKeyedArchiver.archiveRootObject(self.alarms, toFile: filePath)
    }
    
    
    private func loadFromPersistentStorage() {
        guard let filePath = type(of: self).persistentAlarmsFilePath else { return }
        guard let alarms = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Alarm] else { return }
        self.alarms = alarms
    }
    
    // MARK: - Helpers
    
    static private var persistentAlarmsFilePath: String? {
        let directroies = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        guard let documentsDirectory = directroies.first as NSString? else { return nil }
        return documentsDirectory.appendingPathComponent("Alarms.plist")
    }
    
    func scheduleUserNotifications(for alarm: Alarm) {
        
    }
    
    
}

protocol AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}






