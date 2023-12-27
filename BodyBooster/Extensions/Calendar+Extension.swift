//
//  Calendar+Extension.swift
//  BodyBooster
//
//  Created by ProDoctor on 19/12/23.
//

import Foundation

extension Calendar {
    
    func weekDay(from date: Date, calendar: Calendar = .current) -> Int {
        calendar.component(.weekday, from: date)
    }
    
}
