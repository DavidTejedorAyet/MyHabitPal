//
//  TimeZoneExtension.swift
//  MyHabitPal
//
//

import Foundation

extension TimeZone {
    /**
     All dates should to be worked with the same calendar and timezone. TimeZone.default and Calendar.default are variables that always will be used to work with dates
     */
    static var `default`: TimeZone {
        guard let timeZone = TimeZone(secondsFromGMT: 0) else {
            return Calendar.current.timeZone
        }
        return timeZone
    }
}
