//
//  Settings.swift
//  FindNumber
//
//  Created by Вадим Игнатенко on 25.01.22.
//

import Foundation



enum KeysUserDefaults {
    static let settingsGame = "settingsGame"
    static let recordGame = "recordGame"

}


struct SettingsGame: Codable {
    var timeState: Bool
    var timeForGame: Int
}




class Settings {
    
    static var shared = Settings()
    
    private let defultSettings = SettingsGame (timeState: true, timeForGame: 30)
    
    var currentSettings: SettingsGame {
        get {
            if let data = UserDefaults.standard.object(forKey: KeysUserDefaults.settingsGame) as? Data {
                return try! PropertyListDecoder().decode(SettingsGame.self , from: data)
            } else {
                if let data = try? PropertyListEncoder().encode(defultSettings) {
                    UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.settingsGame)
                }
                return defultSettings
            }
            
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.settingsGame)
            }
            
        }
    }
    
    
    func resetSettings () {
        currentSettings = defultSettings
    }
}
