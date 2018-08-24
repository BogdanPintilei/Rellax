//
//  CollectionViewCell.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/11/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import UIKit

class InformationCollectionViewCell: UICollectionViewCell {

    @IBOutlet var view: UIView!
    @IBOutlet var informationTitleLabel: UILabel!
    @IBOutlet var informationCategoryLabel: UILabel!

    static let nibName = "InformationCollectionViewCell"

    var information: Fact! { didSet { customizeCellWithInformation() } }
    var heroIDIndex: Int! { didSet { setHeroElementsID() } }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeCell()
    }

    private func customizeCell() {
        view.backgroundColor = UIColor.AppColors.darkBlue
    }

    private func customizeCellWithInformation() {
        informationTitleLabel.text = information.title
        informationCategoryLabel.text = information.category
    }

    private func setHeroElementsID() {
        informationTitleLabel.hero.id = HeroIDGenerator.informationTitleLabelHeroID(id: heroIDIndex)
        view.hero.id = HeroIDGenerator.informationDetailsViewHeroID(id: heroIDIndex)
    }

}
