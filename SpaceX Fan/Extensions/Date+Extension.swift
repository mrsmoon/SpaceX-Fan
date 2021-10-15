//
//  Date+Extension.swift
//  SpaceX Fan
//
//  Created by Sera on 10/15/21.
//

import Foundation

typealias RemainingTime = (Int, String)?

extension Date {
    
    func datePhraseRelativeToToday() -> RemainingTime {

        guard let todayEnd = dateEndOfToday() else {
            return nil
        }

        let calendar = Calendar.autoupdatingCurrent

        let units = Set([Calendar.Component.year,
                     Calendar.Component.month,
                     Calendar.Component.weekOfMonth,
                     Calendar.Component.day])

        let difference = calendar.dateComponents(units, from: todayEnd, to: self)

        guard let year = difference.year,
            let month = difference.month,
            let week = difference.weekOfMonth,
            let day = difference.day else {
                return nil
        }

        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale.autoupdatingCurrent
            formatter.dateStyle = .medium
            formatter.doesRelativeDateFormatting = true
            return formatter
        }()

        if year > 0 {
            return (year, "year")
        } else if month > 0 {
            return (month, "month")
        } else if week > 0 {
            return (week, "week")
        } else if day > 1 {
            return (day, "day")
        } else {
            //Sample output: "Yesterday" or "Today"
            return (0, dateFormatter.string(from: self))
        }
    }

    func dateEndOfToday() -> Date? {
        let calendar = Calendar.autoupdatingCurrent
        let now = Date()
        let todayStart = calendar.startOfDay(for: now)
        var components = DateComponents()
        components.day = 1
        let todayEnd = calendar.date(byAdding: components, to: todayStart)
        return todayEnd
    }

}

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
        let date = dateFormatter.date(from: self)!
        return date
    }
}

