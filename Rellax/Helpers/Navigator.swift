//
//  Navigator.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/9/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import UIKit
import Hero

class Navigator {
    
    static let shared = Navigator()
    
    init() {}
    
    func presentBrowseFlow(from viewController: UIViewController) {
        let vc = AppStoryboard.Library.instance.instantiateViewController(withIdentifier: "LibraryViewControllerStoryboardID") as! LibraryViewController
        vc.hero.modalAnimationType = .zoom
        viewController.present(vc, animated: true, completion: nil)
    }

    func presentPlayer(
        from viewController: UIViewController,
        exercise: Track,
        labelHeroID: String,
        letsRollButtonHeroID: String,
        viewHeroID: String
    ) {
        let vc = AppStoryboard.Player.instance.instantiateViewController(withIdentifier: "PlayerViewControllerStroyboardID") as! PlayerViewController
        vc.exerciseTitleLabelHeroID = labelHeroID
        vc.playButtonHeroID = letsRollButtonHeroID
        vc.viewHeroID = viewHeroID
        vc.exercise = exercise
        viewController.present(vc, animated: true, completion: nil)
    }

    func showInformationFlow(
        from viewController: UIViewController,
        exerciseID: Int,
        imageURL: String
    ) {
        let nvc = AppStoryboard.Information.instance.instantiateViewController(withIdentifier: "InformationViewControllerStoryboardID") as! UINavigationController
        nvc.hero.modalAnimationType = .fade
        let vc = nvc.childViewControllers.first as! InformationViewController
        vc.exerciseID = exerciseID
        vc.imageURL = imageURL
        viewController.present(nvc, animated: true, completion: nil)
    }

    func showInformationDetails(
        from viewController: UIViewController,
        exerciseInformation: Fact,
        informationTitleLabelHeroID: String,
        viewHeroID: String
    ) {
        let vc = AppStoryboard.Information.instance.instantiateViewController(withIdentifier: "InformationDetailsViewControllerStoryboardID") as! InformationDetailsViewController
        vc.fact = exerciseInformation
        vc.informationTitleLabelHeroID = informationTitleLabelHeroID
        vc.viewHeroID = viewHeroID
        viewController.present(vc, animated: true, completion: nil)
    }

}


