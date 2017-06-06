//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Nick Reichard on 6/5/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController, SwitchTableViewCellDelegate {

    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         tableView.reloadData()
    }
    
    // MARK: - Custom Prodocol 
    
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let alarm = AlarmController.shared.alarms[indexPath.row]
        AlarmController.shared.toggleEnabled(for: alarm)
        
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return AlarmController.shared.alarms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell else { return SwitchTableViewCell() }
        
        cell.alarm = AlarmController.shared.alarms[indexPath.row]
        
        return cell
    }
 

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarm = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarm)
    
            tableView.deleteRows(at: [indexPath], with: .fade)
 
        }    
    }
 
    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlarmDetail" {
            guard let detailTVC = segue.destination as? AlarmDetailTableViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            detailTVC.alarm = AlarmController.shared.alarms[indexPath.row]
        }
    }

}
