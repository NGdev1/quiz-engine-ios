//
//  Date+ToString.swift
//  General
//
//  Created by Михаил Андреичев on 28.03.2018.
//  Copyright © 2018 md. All rights reserved.
//

import Foundation

public extension Date {
    func getStringDescription() -> String {
        let calendar = Calendar.current
        var interval = Int(timeIntervalSinceNow)

        if interval < 0 {
            interval = -interval
            if calendar.isDateInToday(self) {
                let hours = (interval / 3600) % 24
                if hours == 0 {
                    return getMinutesAgo(from: interval)
                } else {
                    return getHoursAgo(hours: hours)
                }
            } else if calendar.isDateInYesterday(self) {
                return Text.Date.yesterday
            } else {
                return getDay()
            }
        } else {
            if calendar.isDateInToday(self) {
                return getTime()
            } else if calendar.isDateInTomorrow(self) {
                return Text.Date.tomorrow
            } else {
                return getDay()
            }
        }
    }

    func getTime() -> String {
        let dateFormatterTime = DateFormatter()
        dateFormatterTime.dateFormat = "HH:mm"
        return dateFormatterTime.string(from: self)
    }

    func getShortDayString() -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        return dateFormatter.string(from: self)
    }

    func getFullDate() -> String {
        let dateFormatterDate = DateFormatter()
        dateFormatterDate.timeStyle = .none
        dateFormatterDate.dateStyle = .short
        return dateFormatterDate.string(from: self)
    }

    func getDay() -> String {
        let calendar = Calendar.current
        if calendar.isDate(self, equalTo: Date(), toGranularity: .year) {
            return getShortDayString()
        } else {
            return getFullDate()
        }
    }

    func getMinutesAgo(from interval: Int) -> String {
        let minutes = interval / 60
        if minutes == 0 {
            return Text.Date.now
        } else {
            return Text.Date.nMinutesAgo(minutes)
        }
    }

    func getHoursAgo(hours: Int) -> String {
        if hours == 1 {
            return Text.Date.hourAgo
        } else if hours < 5 {
            return Text.Date.hoursAgo2to5(hours)
        } else {
            return Text.Date.hoursAgoFrom5(hours)
        }
    }

    func getMonth() -> String {
        let dateFormatterTime = DateFormatter()
        dateFormatterTime.dateFormat = "LLLL"
        return dateFormatterTime.string(from: self)
    }
}
