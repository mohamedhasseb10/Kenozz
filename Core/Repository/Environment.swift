//
//  Environment.swift
//  Src
//
//  Created by xWARE on 5/4/20.
//  Copyright © 2020 xWARE. All rights reserved.
//

import Foundation

public enum Environment {
    // MARK: - Keys
        enum PlistKeys {
            static let baseURL = "BASE_URL"
            static let registrationURL = "REGISTRATION_URL"
            static let accountURL = "ACCOUNT_URL"
            static let organizationID = "ORGANIZATION_ID"
            static let appID = "APP_ID"
        }

    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()

    // MARK: - Plist values
    static let baseURL: String = {
        guard let baseURLstring = Environment.infoDictionary[PlistKeys.baseURL] as? String else {
            fatalError("base URL not set in plist for this environment")
        }
        guard let url = URL(string: baseURLstring) else {
            fatalError("Base URL is invalid")
        }
        return baseURLstring
    }()

    static let registrationURL: String = {
        guard let registrationURLstring = Environment.infoDictionary[PlistKeys.registrationURL] as? String else {
            fatalError("registration URL not set in plist for this environment")
        }
        guard let url = URL(string: registrationURLstring) else {
            fatalError("Registration URL is invalid")
        }
        return registrationURLstring
    }()

    static let accountURL: String = {
        guard let accountURLstring = Environment.infoDictionary[PlistKeys.accountURL] as? String else {
            fatalError("account URL not set in plist for this environment")
        }
        guard let url = URL(string: accountURLstring) else {
            fatalError("Account URL is invalid")
        }
        return accountURLstring
    }()

    static let organizationID: String = {
        guard let organizationID = Environment.infoDictionary[PlistKeys.organizationID] as? String else {
            fatalError("organization ID not set in plist for this environment")
        }
        return organizationID
    }()

    static let appID: String = {
        guard let appID = Environment.infoDictionary[PlistKeys.appID] as? String else {
            fatalError("API Key not set in plist for this environment")
        }
        return appID
    }()
}
