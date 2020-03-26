//
//  MPVolumeView.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/10/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import Foundation
import MediaPlayer

extension MPVolumeView {
    
    static func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume;
        }
    }
    
}
