//
//  UserDefaults+States.swift
//  Src
//
//  Created by BobaHasseb on 8/6/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

extension UserDefaults {
    private struct Keys {
        static let isLoggedIn: String = "userLoggedIn"
        static let userID: String = "userID"
        static let userName: String = "userName"
        static let name: String = "name"
        static let lName: String = "lName"
        static let userEmail: String = "userEmail"
        static let userImagePath: String = "userImagePath"
        static let apiToken: String = "apiToken"
        static let badgeValue: String = "badgeValue"
    }
    public var isLoggedIn: Bool {
        set {
            set(newValue, forKey: Keys.isLoggedIn)
        }
        get {
            return bool(forKey: Keys.isLoggedIn)
        }
    }
    public var userID: Int? {
        set {
            set(newValue, forKey: Keys.userID)
        }
        get {
            guard let userID = value(forKey: Keys.userID) as? Int
                else { return nil }
            return userID
        }
    }
    public var userName: String? {
        set {
            set(newValue, forKey: Keys.userName)
        }
        get {
            guard let userName = value(forKey: Keys.userName) as? String else { return nil }
            return userName
        }
    }
    public var name: String? {
        set {
            set(newValue, forKey: Keys.name)
        }
        get {
            guard let name = value(forKey: Keys.name) as? String else { return nil }
            return name
        }
    }
    public var lName: String? {
        set {
            set(newValue, forKey: Keys.lName)
        }
        get {
            guard let lName = value(forKey: Keys.lName) as? String else { return nil }
            return lName
        }
    }
    public var userEmail: String? {
        set {
            set(newValue, forKey: Keys.userEmail)
        }
        get {
            guard let userEmail = value(forKey: Keys.userEmail) as? String else { return nil }
            return userEmail
        }
    }
    public var userImagePath: String? {
        set {
            set(newValue, forKey: Keys.userImagePath)
        }
        get {
            guard let userImagePath = value(forKey: Keys.userImagePath) as? String else { return nil }
            return userImagePath
        }
    }
    public var apiToken: String? {
        set {
            set(newValue, forKey: Keys.apiToken)
        }
        get {
            guard let apiToken = value(forKey: Keys.apiToken) as? String else { return nil }
            return apiToken
        }
    }
    public var badgeValue: String? {
        set {
            set(newValue, forKey: Keys.badgeValue)
        }
        get {
            guard let badgeValue = value(forKey: Keys.badgeValue) as? String else {
                return nil }
            return badgeValue
        }
    }
}
