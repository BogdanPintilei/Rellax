//
//  InformationDetailsViewController.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/3/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import UIKit
import Kingfisher

class InformationDetailsViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var informationTitleLabel: UILabel!
    @IBOutlet var informationContentLabel: UILabel!
    
    var fact = Fact()
    var informationTitleLabelHeroID = ""
    var viewHeroID = ""
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fillInFactData()
        setHeroElementsID()
    }

    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    private func fillInFactData() {
        backgroundImageView.kf.indicatorType = .activity
        backgroundImageView.kf.setImage(with: URL(string: fact.imageURL!))
        informationTitleLabel.text = fact.title
        informationContentLabel.text = fact.content
    }
    
    private func setHeroElementsID() {
        informationTitleLabel.hero.id = informationTitleLabelHeroID
        self.view.hero.id = viewHeroID
    }
    
}
