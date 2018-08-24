//
//  HomeViewController.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/2/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var playButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
    }
    
    @IBAction func showBrowseFlow(_ sender: Any) {
        Navigator.shared.presentBrowseFlow(from: self)
    }
    
    private func customizeUI() {
        playButton.setRoundFrame()
        view.addActivityIndicator(size: playButton.frame.size.height, lineWidth: 4)
    }
    
}
