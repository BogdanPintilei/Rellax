//
//  PlayerSlider.swift
//  Mindfulness
//
//  Created by Bogdan Pintilei on 7/9/18.
//  Copyright © 2018 Wolfpack. All rights reserved.
//

import UIKit

class PlayerVolumeSlider: UISlider {

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var newBounds = super.trackRect(forBounds: bounds)
        newBounds.size.height = GlobalVariables.sliderHeight
        return newBounds
    }

}

