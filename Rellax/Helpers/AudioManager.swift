//
//  AudioManager.swift
//  Mindfulness
//
//  Created by Bogdan Pintilei on 7/11/18.
//  Copyright © 2018 Wolfpack. All rights reserved.
//

import Foundation
import MediaPlayer

class AudioManager: NSObject {

    static let shared = AudioManager()
    let audioSession = AVAudioSession.sharedInstance()
    let volume = Dynamic<Float>(0.0)

    override init() {}

    func listenVolumeButtons() {
        do {
            try audioSession.setActive(true)
            let vol = audioSession.outputVolume
            self.volume.value = vol
        }
        catch {
            print("Error info: \(error)")
        }
        audioSession.addObserver(self, forKeyPath: Keys.audioSessionKey, options:
                NSKeyValueObservingOptions.new, context: nil)
    }

    func deinititalize() {
        audioSession.removeObserver(self, forKeyPath: Keys.audioSessionKey)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == Keys.audioSessionKey {
            if let volume = (change?[NSKeyValueChangeKey.newKey] as?
                NSNumber)?.floatValue {
                self.volume.value = volume
            }
        }
    }

}
