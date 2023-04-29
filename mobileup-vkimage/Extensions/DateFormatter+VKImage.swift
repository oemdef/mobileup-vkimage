//
//  DateFormatter+VKImage.swift
//  mobileup-vkimage
//
//  Created by OemDef | HansaDev on 29.04.2023.
//

import Foundation

extension DateFormatter {
    static let titleFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM yyyy"
        return formatter
    }()
}
