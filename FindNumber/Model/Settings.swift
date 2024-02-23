//
//  Settings.swift
//  FindNumber
//
//  Created by Вадим Игнатенко on 25.01.22.
//

import Foundation


// MARK: - enums

enum KeysUserDefaults {
    static let settingsGame = "settingsGame"
    static let recordGame = "recordGame"
}

// MARK: - struct

struct SettingsGame: Codable {
    var timeState: Bool
    var timeForGame: Int
}

// MARK: - class

final class Settings {
    
    // MARK: - properties
    
    private let defultSettings = SettingsGame (timeState: true, timeForGame: 30)
    static var shared = Settings()
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
    
    // MARK: - methods

    func resetSettings () {
        currentSettings = defultSettings
    }
}
