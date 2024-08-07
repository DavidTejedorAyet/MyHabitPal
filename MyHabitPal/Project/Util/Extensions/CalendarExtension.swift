//
//  CalendarExtension.swift
//  MyHabitPal
//
//

import Foundation

extension Calendar {
    /**
     All dates should to be worked with the same calendar and timezone. TimeZone.default and Calendar.default are variables that always will be used to work with dates
     */
    static var `default`: Calendar {
        var nCalendar = Calendar(identifier: .gregorian)
        nCalendar.timeZone = TimeZone.default

        // If, in the future, we need to change days order on the calendar, we will need to change nCalendar.locale dynamically (Locale.current)
        nCalendar.locale = Locale(identifier: "en_US_POSIX")

        return nCalendar
    }

    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>

        return numberOfDays.day!
    }
}
