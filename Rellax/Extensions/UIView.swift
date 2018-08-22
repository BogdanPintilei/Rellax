//
//  UIView.swift
//  Mindfulness
//
//  Created by Bogdan Pintilei on 7/3/18.
//  Copyright © 2018 Wolfpack. All rights reserved.
//

import UIKit
import GradientCircularProgress

extension UIView {

    func setRoundFrame() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }

    func setRoundFrameForLength() {
        self.layer.masksToBounds = false
        layer.cornerRadius = frame.size.height / 2
        self.clipsToBounds = true
    }
    
    func addActivityIndicator(size: CGFloat, lineWidth: CGFloat) {
        let progress = GradientCircularProgress()
        let progressView = progress.show(frame: self.frame, style: CircularSpinnerStyle(progressSize: size, lineWidth: lineWidth))
        self.addSubview(progressView!)
    }
    
    func animateButton() {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.transform = CGAffineTransform.identity
                        }
        })
    }

}
