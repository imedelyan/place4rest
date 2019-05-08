//
//  Language.swift
//  place4rest
//
//  Created by Igor Medelian on 5/7/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

private let appleLanguagesKey = "AppleLanguages"

enum AppLanguage: String {

    case ukrainian = "uk"
    case english = "en"
    case russian = "ru"

    static var startLanguage = AppLanguage.english

    static var languages: [AppLanguage] = [.ukrainian, .english, .russian]

    static var language: AppLanguage {
        get {
            if let languageCode = UserDefaults.standard.string(forKey: appleLanguagesKey),
                let language = AppLanguage(rawValue: languageCode) {
                return language
            } else {
                let preferredLanguage = NSLocale.preferredLanguages[0] as String
                let index = preferredLanguage.index(preferredLanguage.startIndex, offsetBy: 2)
                guard let localization = AppLanguage(rawValue: String(preferredLanguage[..<index])) else {
                    return .english
                }
                return localization
            }
        }
        set {
            guard language != newValue else {
                return
            }
            //change language in the app
            //the language will be changed after restart
            UserDefaults.standard.set([newValue.rawValue], forKey: appleLanguagesKey)
            UserDefaults.standard.synchronize()
        }
    }

    var displayName: String {
        let locale = NSLocale(localeIdentifier: self.rawValue)
        var displayName = locale.displayName(forKey: .identifier, value: self.rawValue)!
        displayName = displayName.capitalizingFirstLetter()
        return displayName
    }

    static func displayNameFromValue(_ name: String) -> String {
        let locale = NSLocale(localeIdentifier: name)
        var displayName = locale.displayName(forKey: .identifier, value: name)!
        displayName = displayName.capitalizingFirstLetter()
        return displayName
    }

    static func languageFromValue(_ value: String) -> AppLanguage {
        switch value {
        case "en":
            return .english
        case "ua":
            return .ukrainian
        case "ru":
            return .russian
        default:
            return .english
        }
    }
}
