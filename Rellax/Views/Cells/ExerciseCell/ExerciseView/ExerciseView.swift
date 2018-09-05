//
//  ExerciseView.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/4/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import UIKit
import Hero
import Kingfisher

protocol ExerciseViewDelegate: class {
    func showInformationFlow(exerciseID: Int, imageURL: String?)
    func showPlayerScreen()
}

class ExerciseView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet var exerciseImageView: UIImageView!
    @IBOutlet var exerciseImageViewTint: UIImageView!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var letsRollButton: UIButton!

    var exercise: Exercise! { didSet { customizeViewWithExercise() } }
    var heroIDIndex: Int! { didSet { setHeroElementsID() } }
    weak var delegate: ExerciseViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "ExerciseView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        customizeUI()
    }

    @IBAction func letsRoll(_ sender: Any) {
        delegate?.showPlayerScreen()
    }

    @IBAction func getInformation(_ sender: Any) {
        delegate?.showInformationFlow(exerciseID: exercise.id!, imageURL: exercise.imageURL!)
    }

    private func customizeUI() {
        exerciseImageViewTint.backgroundColor = UIColor.AppColors.blueMask
        letsRollButton.setRoundFrameForLength()
    }

    private func customizeViewWithExercise() {
        exerciseImageView.kf.indicatorType = .activity
        exerciseImageView.kf.setImage(with: URL(string: exercise.imageURL!))
        durationLabel.text = "\(String(describing: exercise.duration!))"
        durationLabel.text =  Date.secondsToString(seconds: Int(exercise.duration!))
        titleLabel.text = exercise.title
        descriptionLabel.text = exercise.exerciseDescription
    }

    private func setHeroElementsID() {
        titleLabel.hero.id = HeroIDGenerator.libraryExerciseTitleHeroID(id: heroIDIndex)
        letsRollButton.hero.id = HeroIDGenerator.libraryButtonTitleHeroID(id: heroIDIndex)
        view.hero.id = HeroIDGenerator.libraryViewHeroID(id: heroIDIndex)
    }
    
}
