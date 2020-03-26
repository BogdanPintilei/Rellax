//
//  ExerciseCollectionViewCell.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/4/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import UIKit

class ExerciseCollectionViewCell: UICollectionViewCell {

    @IBOutlet var exerciseView: ExerciseView!
    
    var exercise: Track! { didSet { exerciseView.exercise = exercise } }
    
}
