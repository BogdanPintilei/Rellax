//
//  LoadingView.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/3/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

enum IndicatorType: String {
    case regular
    case audio
}

class LoadingView: UIView {

    static let indicatorView = NVActivityIndicatorView(
        frame: CGRect.zero,
        type: .ballScale,
        color: UIColor.white,
        padding: 20
    )

    static let audioIndicatorView = NVActivityIndicatorView (
        frame: CGRect.zero,
        type: .circleStrokeSpin,
        color: UIColor.white,
        padding: 20
    )

    static let win: UIWindow = UIApplication.shared.delegate!.window!!

    static func startLoadingAnimation(indicatorType: IndicatorType, view: UIView? = win) {
        guard  let customView = view else {
            print("view does not exist")
            return
        }
        switch indicatorType {
        case .regular:
            startLoadingAnimation(indicatorView: indicatorView, view: customView)
        case .audio:
            startLoadingAnimation(indicatorView: audioIndicatorView, view: customView)
        }
    }

    static func stopLoadingAnimation(indicatorType: IndicatorType) {
        switch indicatorType {
        case .regular:
            stopLoadingAnimation(indicatorView)
        case .audio:
            stopLoadingAnimation(audioIndicatorView)
        }
    }

    private class func startLoadingAnimation(indicatorView: NVActivityIndicatorView, view: UIView? = win) {
        indicatorView.center = view == win ? view!.center : CGPoint(x: view!.bounds.height / 2, y: view!.bounds.width / 2)
        view!.addSubview(indicatorView)
        indicatorView.startAnimating()
    }

    private class func stopLoadingAnimation(_ indicatorView: NVActivityIndicatorView) {
        indicatorView.stopAnimating()
        indicatorView.removeFromSuperview()
    }

    static func setLoadingViewColor(color: UIColor) {
        indicatorView.color = color
    }

}
