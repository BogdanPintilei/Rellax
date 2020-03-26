//
//  HeroIDGenerator.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/9/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import Foundation

struct HeroIDGenerator {
    
    static func libraryExerciseTitleHeroID(id: Int) -> String {
        return "lib_ex_title\(id)"
    }
    
    static func libraryButtonTitleHeroID(id: Int) -> String {
        return "lib_bttn_title\(id)"
    }
    
    static func libraryViewHeroID(id: Int) -> String {
        return "lib_view\(id)"
    }
    
    static func informationTitleLabelHeroID(id: Int) -> String {
        return "info_title_label\(id)"
    }
    
    static func informationDetailsViewHeroID(id: Int) -> String {
        return "info_view\(id)"
    }
    
}
