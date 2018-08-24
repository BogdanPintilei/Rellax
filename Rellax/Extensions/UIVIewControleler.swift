//
//  UIVIewControlelr.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/11/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import UIKit

extension UIViewController {

    // MARK: Navigation controller helper methods

    func setNavigationBarTransparent() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }

    func setNavigationBarFont(ofSize size: CGFloat, andWeight weight: UIFont.Weight, ofColor color: UIColor) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: size, weight: weight), NSAttributedStringKey.foregroundColor: color]
    }

}
