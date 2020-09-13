//
//  Environment.swift
//  Src
//
//  Created by BobaHasseb on 5/4/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
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
            static let gulfhorseq = "GULF_HORSEQ"
            static let souqvis = "SOUQ_VIS"
            static let kuwaitfactories = "KUWAIT_FACTORIES"
            static let medicalhighcoder = "MEDICAL_HIGHCODER"
            static let hoursehighcoder = "HIGHCODER"
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
    static let gulfhorseqURL: String = {
        guard let gulfhorseqURLstring = Environment.infoDictionary[PlistKeys.gulfhorseq] as? String else {
            fatalError("gulfhorseq URL not set in plist for this environment")
        }
        guard let url = URL(string: gulfhorseqURLstring) else {
            fatalError("gulfhorseq URL is invalid")
        }
        return gulfhorseqURLstring
    }()
    static let souqvisURL: String = {
        guard let souqvisURLstring = Environment.infoDictionary[PlistKeys.souqvis] as? String else {
            fatalError("souqvis URL not set in plist for this environment")
        }
        guard let url = URL(string: souqvisURLstring) else {
            fatalError("souqvis URL is invalid")
        }
        return souqvisURLstring
    }()
    static let kuwaitfactoriesURL: String = {
        guard let kuwaitfactoriesURLstring = Environment.infoDictionary[PlistKeys.kuwaitfactories] as? String else {
            fatalError("kuwaitfactories URL not set in plist for this environment")
        }
        guard let url = URL(string: kuwaitfactoriesURLstring) else {
            fatalError("kuwaitfactories URL is invalid")
        }
        return kuwaitfactoriesURLstring
    }()
    static let medicalhighcoderURL: String = {
        guard let medicalhighcoderURLstring = Environment.infoDictionary[PlistKeys.medicalhighcoder] as? String else {
            fatalError("medicalhighcoder URL not set in plist for this environment")
        }
        guard let url = URL(string: medicalhighcoderURLstring) else {
            fatalError("medicalhighcoder URL is invalid")
        }
        return medicalhighcoderURLstring
    }()
    static let hoursehighcoderURL: String = {
        guard let hoursehighcoderURLstring = Environment.infoDictionary[PlistKeys.hoursehighcoder] as? String else {
            fatalError("hoursehighcoder URL not set in plist for this environment")
        }
        guard let url = URL(string: hoursehighcoderURLstring) else {
            fatalError("hoursehighcoder URL is invalid")
        }
        return hoursehighcoderURLstring
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
