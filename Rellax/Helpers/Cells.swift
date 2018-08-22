//
//  Cells.swift
//  Mindfulness
//
//  Created by Bogdan Pintilei on 7/11/18.
//  Copyright © 2018 Wolfpack. All rights reserved.
//

import Foundation

enum Cells: String {
    
    case library, information
    
    var cell: String {
        switch self {
        case .information:
            return "InformationCollectionViewCellID"
        case .library:
            return "exerciseCollectionViewCellID"
        }
    }
    
}
