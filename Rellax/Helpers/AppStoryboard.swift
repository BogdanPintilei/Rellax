//
//  AppStoryboard.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/5/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryboard: String {
    
    case Main, Library, Player, Information
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
}
