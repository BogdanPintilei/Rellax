//
//  Helper.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/16/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import Foundation

class PlayerHelper {

    func getCurrentTimeLabel(from seconds: Int) -> String {
        let (m, s) = secondsToMinutesSeconds(seconds: seconds)
        let seconds = s < 10 ? "0\(s)" : "\(s)"
        return "\(m):\(seconds)"
    }

    private func secondsToMinutesSeconds (seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }

}
