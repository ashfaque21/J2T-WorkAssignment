//
//  UIDate+Month.swift
//  J2T_Assignment
//
//  Created by Aahil Tamboli on 06/08/20.
//  Copyright © 2020 Ashfaque Tamboli. All rights reserved.
//

import Foundation

extension Date
{

    func getDate(_ dateString : String) -> Date? {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
          dateFormatter.timeZone = TimeZone.current
          dateFormatter.locale = Locale.current
          return dateFormatter.date(from: dateString)
      }
    
    
    func getNumberOfMonths(date : Date) -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.year, .month]
        dateComponentsFormatter.unitsStyle = .full
        let date_difference = dateComponentsFormatter.string(from: date, to: currentDate)
        return date_difference!
    }
}
