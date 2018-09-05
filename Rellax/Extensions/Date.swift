//
//  Date.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 9/5/18.
//  Copyright © 2018 Bogdan Pintilei. All rights reserved.
//

import Foundation

import Foundation

extension Date {
    
    static func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    static func secondsToString(seconds: Int) -> String {
        let (h, m, s) = secondsToHoursMinutesSeconds(seconds: seconds)
        return "\(m)'\(s)''"
    }
    
}
