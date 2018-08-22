//
//  CircularSpinnerStyle.swift
//  Mindfulness
//
//  Created by Bogdan Pintilei on 7/4/18.
//  Copyright © 2018 Wolfpack. All rights reserved.
//

import GradientCircularProgress

public struct CircularSpinnerStyle: StyleProperty {

    public var progressSize: CGFloat = 1
    public var arcLineWidth: CGFloat = 2
    public var baseLineWidth: CGFloat? = 2
    public var startArcColor: UIColor = UIColor.clear
    public var endArcColor: UIColor = UIColor.AppColors.pink
    public var backgroundStyle: BackgroundStyles = .none

    public var baseArcColor: UIColor? = nil
    public var ratioLabelFont: UIFont? = nil
    public var ratioLabelFontColor: UIColor? = nil
    public var messageLabelFont: UIFont? = nil
    public var messageLabelFontColor: UIColor? = nil
    public var dismissTimeInterval: Double? = nil

    public init() {}

    init(progressSize: CGFloat? = 1, lineWidth: CGFloat? = 2) {
        self.arcLineWidth = lineWidth!
        self.baseLineWidth = lineWidth
        self.progressSize = progressSize! + self.arcLineWidth + self.baseLineWidth!
    }
    
}
