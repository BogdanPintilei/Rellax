//
//  UIImage.swift
//  Mindfulness
//
//  Created by Bogdan Pintilei on 7/9/18.
//  Copyright © 2018 Wolfpack. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func circle(diameter: CGFloat, color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: diameter, height: diameter), false, 0)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.saveGState()

        let rect = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        ctx.setFillColor(color.cgColor)
        ctx.fillEllipse(in: rect)

        ctx.restoreGState()
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return img
    }
    
}
