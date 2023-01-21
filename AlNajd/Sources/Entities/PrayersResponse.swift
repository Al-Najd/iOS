//
//  File.swift
//
//
//  Created by Ahmed Ramy on 28/02/2022.
//

import Foundation

// MARK: - PrayerSchedule

public class PrayerScheduleResponse: Codable {
    public let code: Int
    public let status: String
    public let results: PrayersSchedule

    enum CodingKeys: String, CodingKey {
        case code
        case status
        case results
    }

    public init(code: Int, status: String, results: PrayersSchedule) {
        self.code = code
        self.status = status
        self.results = results
    }
}

// MARK: - Results

public class PrayersSchedule: Codable {
    let datetime: [Datetime]
    let location: Location
    let settings: Settings

    enum CodingKeys: String, CodingKey {
        case datetime
        case location
        case settings
    }

    public init(datetime: [Datetime], location: Location, settings: Settings) {
        self.datetime = datetime
        self.location = location
        self.settings = settings
    }
}

// MARK: - Datetime

public class Datetime: Codable {
    let times: Times
    let date: DateClass

    enum CodingKeys: String, CodingKey {
        case times
        case date
    }

    public init(times: Times, date: DateClass) {
        self.times = times
        self.date = date
    }
}

// MARK: - DateClass

public class DateClass: Codable {
    let timestamp: Int
    let gregorian: String
    let hijri: String

    enum CodingKeys: String, CodingKey {
        case timestamp
        case gregorian
        case hijri
    }

    public init(timestamp: Int, gregorian: String, hijri: String) {
        self.timestamp = timestamp
        self.gregorian = gregorian
        self.hijri = hijri
    }
}

// MARK: - Times

public class Times: Codable {
    let imsak: String
    let sunrise: String
    let fajr: String
    let dhuhr: String
    let asr: String
    let sunset: String
    let maghrib: String
    let isha: String
    let midnight: String

    enum CodingKeys: String, CodingKey {
        case imsak
        case sunrise
        case fajr
        case dhuhr
        case asr
        case sunset
        case maghrib
        case isha
        case midnight
    }

    public init(imsak: String, sunrise: String, fajr: String, dhuhr: String, asr: String, sunset: String, maghrib: String, isha: String, midnight: String) {
        self.imsak = imsak
        self.sunrise = sunrise
        self.fajr = fajr
        self.dhuhr = dhuhr
        self.asr = asr
        self.sunset = sunset
        self.maghrib = maghrib
        self.isha = isha
        self.midnight = midnight
    }
}

// MARK: - Location

public class Location: Codable {
    let latitude: Double
    let longitude: Double
    let elevation: Int
    let country: String
    let countryCode: String
    let timezone: String
    let localOffset: Int

    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case elevation
        case country
        case countryCode
        case timezone
        case localOffset
    }

    public init(latitude: Double, longitude: Double, elevation: Int, country: String, countryCode: String, timezone: String, localOffset: Int) {
        self.latitude = latitude
        self.longitude = longitude
        self.elevation = elevation
        self.country = country
        self.countryCode = countryCode
        self.timezone = timezone
        self.localOffset = localOffset
    }
}

// MARK: - Settings

public class Settings: Codable {
    let timeformat: String
    let school: String
    let juristic: String
    let highlat: String
    let fajrAngle: Double
    let ishaAngle: Int

    enum CodingKeys: String, CodingKey {
        case timeformat
        case school
        case juristic
        case highlat
        case fajrAngle
        case ishaAngle
    }

    init(timeformat: String, school: String, juristic: String, highlat: String, fajrAngle: Double, ishaAngle: Int) {
        self.timeformat = timeformat
        self.school = school
        self.juristic = juristic
        self.highlat = highlat
        self.fajrAngle = fajrAngle
        self.ishaAngle = ishaAngle
    }
}
