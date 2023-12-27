//
//  Date+Extension.swift
//  BodyBooster
//
//  Created by ProDoctor on 19/12/23.
//

import Foundation

extension Date {
    
    func weekDay(calendar: Calendar = .current) -> Int {
        calendar.component(.weekday, from: self)
    }
    
}
