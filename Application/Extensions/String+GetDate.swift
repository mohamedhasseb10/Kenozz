//
//  String+GetDate.swift
//  Src
//
//  Created by BobaHasseb on 9/13/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation

extension String {
    func getDate() -> Date? {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
         dateFormatter.timeZone = TimeZone(abbreviation: "en_US_POSIX")
         let convertedDate = dateFormatter.date(from: self)!
         return convertedDate
     }
    func getDatee() -> Date? {
        let isoDate = "2020-04-1T10:44:00+0000"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: isoDate)!
    }
    func getYear() -> String {
        let tokens = self.components(separatedBy: "-")
        print(tokens)
        let year = tokens[0]
        print("weeee\(year)")
        return year
    }
}

extension Date {
    // MARK: - ConverteDateToString
    func convertDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateConverted = dateFormatter.string(from: self)
        return dateConverted
    }
    // MARK: - GetDayName
    func getDayName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: self)
        return dayInWeek
    }
    // MARK: - GetMonthNumber
    func getMonthNumber() -> String {
        let dayOnMonth =  Calendar.current.ordinality(of: .day, in: .month, for: self)
        return "\(dayOnMonth ?? 0 )"
    }
    // MARK: - GetMonthName
    func getMonthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMM")
        return dateFormatter.string(from: self)
    }
}
