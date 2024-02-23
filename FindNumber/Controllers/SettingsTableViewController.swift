//
//  SettingsTableViewController.swift
//  FindNumber
//
//  Created by Вадим Игнатенко on 25.01.22.
//

import UIKit


final class SettingsTableViewController: UITableViewController {

    // MARK: - properties

    @IBOutlet weak var timeGameLabel: UILabel!
    @IBOutlet weak var switchTimer: UISwitch!

    // MARK: - life cycle VC

    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        loadSettings()
    }
    
    // MARK: - methods

    @IBAction private func changeTimerState(_ sender: UISwitch) {
        Settings.shared.currentSettings.timeState = sender.isOn
    }
    
    
    @IBAction private func resetSettings(_ sender: Any) {
        Settings.shared.resetSettings()
        loadSettings()
    }
    
    
    private func loadSettings () {
        timeGameLabel.text =
        " \(Settings.shared.currentSettings.timeForGame) сек"
        switchTimer.isOn =  Settings.shared.currentSettings.timeState
    }

    // MARK: - segue method

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch  segue.identifier{
        case "selectTimeVC":
            if  let vc = segue.destination as? SelectTimeViewController {
                vc.data = [10,20,30,40,50,60,70,80,90,100,110,120]
            }
        default: break
        }
    }
}
