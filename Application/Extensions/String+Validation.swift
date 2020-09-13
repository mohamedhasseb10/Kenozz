//
//  String+Validation.swift
//  Src
//
//  Created by BobaHasseb on 8/6/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

extension String {
    func isValidCountryCode() -> Bool {
        let regex = try? NSRegularExpression(pattern: "^+[+0-9]*$", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    func isValidStringName() -> Bool {
        let regex = try? NSRegularExpression(pattern: "^(?!\\s)[a-zA-Z ]{3,15}$", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    func isValidMobile() -> Bool {
        if count == 0 { return true }
        let regex = try? NSRegularExpression(pattern: "^+[+0-9]{8,15}$", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        guard  emailPredicate.evaluate(with: self) else {
            return false
        }
        return true
    }
    func isValidPassword() -> Bool {
        if self.count < 3 { return false }
        return true
    }
}
