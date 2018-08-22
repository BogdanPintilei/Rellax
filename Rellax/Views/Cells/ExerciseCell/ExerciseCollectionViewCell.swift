//
//  ExerciseCollectionViewCell.swift
//  Mindfulness
//
//  Created by Bogdan Pintilei on 7/4/18.
//  Copyright © 2018 Wolfpack. All rights reserved.
//

import UIKit

class ExerciseCollectionViewCell: UICollectionViewCell {

    @IBOutlet var exerciseView: ExerciseView!
    
    var exercise: Exercise! { didSet { exerciseView.exercise = exercise } }
    
}
