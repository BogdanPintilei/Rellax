//
//  UIImageView.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 9/5/18.
//  Copyright © 2018 Bogdan Pintilei. All rights reserved.
//

import UIKit

extension UIImageView {

    func addBlurEffect(withStyle style: UIBlurEffectStyle) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
}
