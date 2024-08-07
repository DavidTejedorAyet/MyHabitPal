//
//  DateExtension.swift
//  MyHabitPal
//
//  Created by Daniel Plata on 10/7/24.
//  Copyright © 2024 mo2o. All rights reserved.
//

import Foundation


extension Date {
	enum DateFormat: String {
		case short = "dd/MM/yyyy"
		case serverDateTime = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		case dateLongWithTimeZone = "EEE, dd MMM yyyy HH:mm:ss z"
	}

    // MARK: - Static Methods

    static var today: Date {
        Date().default().formattedWithoutTime()
    }

    static var tomorrow: Date {
        Date().default().byAdding(component: .day, value: 1)
    }

    static var initialBirthDate: Date {
        let components = DateComponents(year: 1900)
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(from: components) ?? Date().default()
    }

    static var endBirthDate: Date {
        Date().byAdding(component: .year, value: -18)
    }

    static var defaultStartDate: Date {
        Date().byAdding(component: .year, value: -100)
    }

    static var defaultEndDate: Date {
        Date().byAdding(component: .year, value: 100)
    }
    static var firstDateOfYear: Date {
        Date().default().startOfYear()
    }

    static var lastDateOfYear: Date {
        Date().default().endOfYear()
    }

    static func daysBetween(start: Date, end: Date) -> Int? {
       Calendar.default.dateComponents([.day], from: start, to: end).day
    }

    static func monthsBetween(start: Date, end: Date) -> Int? {
       Calendar.default.dateComponents([.month], from: start, to: end).month
    }

    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate

        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.default.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }

        return dates
    }

    // MARK: - Instance Methods

    func formattedWithoutTime() -> Date {
        Calendar.default.date(bySettingHour: 0, minute: 0, second: 0, of: self) ?? self
    }

    func byAdding(component: Calendar.Component, value: Int) -> Date {
        Calendar.default.date(byAdding: component, value: value, to: self) ?? self
    }

    func startOfYear() -> Date {
        guard let interval: DateInterval = Calendar.default.dateInterval(of: .year, for: self.formattedWithoutTime()) else { return self }
        return interval.start
    }

    func endOfYear() -> Date {
        guard let interval: DateInterval = Calendar.default.dateInterval(of: .year, for: self.formattedWithoutTime()) else { return self }
        return interval.end.byAdding(component: .second, value: -1)
    }

    func startOfMonth() -> Date {
        guard let interval: DateInterval = Calendar.default.dateInterval(of: .month, for: self.formattedWithoutTime()) else { return self }
        return interval.start
    }

    func endOfMonth() -> Date {
        guard let interval: DateInterval = Calendar.default.dateInterval(of: .month, for: self.formattedWithoutTime()) else { return self }
        return interval.end.byAdding(component: .second, value: -1)
    }

    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        (min(date1, date2) ... max(date1, date2)).contains(self)
    }

    func isGreaterThanDate(dateToCompare: Date) -> Bool {
        // Declare Variables
        var isGreater = false

        // Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }

        // Return Result
        return isGreater
    }

    func isLessThanDate(dateToCompare: Date) -> Bool {
        // Declare Variables
        var isLess = false

        // Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }

        // Return Result
        return isLess
    }

    func equalToDate(dateToCompare: Date) -> Bool {
        // Declare Variables
        var isEqualTo = false

        // Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }

        // Return Result
        return isEqualTo
    }

    func isSameMonth(fromDate: Date) -> Bool {
        let components1 = Calendar.default.component(Calendar.Component.month, from: self)
        let components2 = Calendar.default.component(Calendar.Component.month, from: fromDate)

        return components1 == components2
    }

    func `default`() -> Date {
        self.formattedWithoutTime()
    }

	func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
		dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

	func toString(format: DateFormat) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone(identifier: "UTC")
		dateFormatter.dateFormat = format.rawValue
		return dateFormatter.string(from: self)
	}

	init?(from date: String, withFormat: DateFormat) {
		let formatter = DateFormatter()
		formatter.dateFormat = withFormat.rawValue

		if let date = formatter.date(from: date) {
			self = date
		} else {
			return nil
		}
	}
}
