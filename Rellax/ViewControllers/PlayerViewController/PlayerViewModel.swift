//
//  PlayerViewModel.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/3/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer

class PlayerViewModel {

    var audioPlayer: AudioPlayer?
    var totalDuration = Dynamic<TimeInterval>(0.0)
    var currenTime = Dynamic<TimeInterval>(0.0)

    var hasStarted = Dynamic<Bool>(false)
    var isPlaying = Dynamic<Bool>(false)
    var isLoading = Dynamic<Bool>(false)
    var isReady = Dynamic<Bool>(false)

    func initializeAudio(audioURL: String) {
        audioPlayer = AudioPlayer(url: audioURL)
        bindAudioPlayer()
    }

    func deinitializeAudio() {
        self.stop()
        audioPlayer = AudioPlayer()
    }

    func playOrPauseAudio() {
        isPlaying.value ? audioPlayer?.pause() : audioPlayer?.play()
    }

    func stop() {
        audioPlayer?.stop()
    }

    func setCurrentTime(value: TimeInterval) {
        audioPlayer?.setCurrentTime(value: value)
    }

    func setVolume(value: Float) {
        MPVolumeView.setVolume(value)
    }

    func handle(meteringLevels: [Float]) -> [Float] {
        if meteringLevels.count < 100 {
            var doubleMetering = [Float]()
            while doubleMetering.count < 100 {
                for i in 0..<meteringLevels.count {
                    doubleMetering.append(contentsOf: [meteringLevels[i], meteringLevels[i]])
                }
                return doubleMetering
            }
        }
        return meteringLevels
    }

    private func audioDuration(for resource: URL) -> TimeInterval {
        let asset = AVURLAsset(url: resource)
        return asset.duration.seconds
    }

    private func bindAudioPlayer() {
        audioPlayer?.totalDuration.bind { [weak self] (duration) in
            guard let `self` = self else { return }
            self.totalDuration.value = duration
            print("The total duration is: \(duration)")
        }
        audioPlayer?.currentTime.bindAndFire { [weak self] (currentTime) in
            guard let `self` = self else { return }
            self.currenTime.value = currentTime
            print("The current time is: \(currentTime)")
        }
        audioPlayer?.isPlaying.bind { [weak self] (isPlaying) in
            guard let `self` = self else { return }
            self.isPlaying.value = isPlaying
            print("is playing: \(isPlaying)")
        }
        audioPlayer?.isLoading.bind { [weak self] (isLoading) in
            guard let `self` = self else { return }
            self.isLoading.value = isLoading
            print("is loading: \(isLoading)")
        }
        audioPlayer?.hasStarted.bind { [weak self] (hasStarted) in
            guard let `self` = self else { return }
            self.hasStarted.value = hasStarted
            print("has started: \(hasStarted)")
        }
        audioPlayer?.isReady.bind { [weak self] (isReady) in
            guard let `self` = self else { return }
            self.isReady.value = isReady
            print("is Ready: \(isReady)")
        }
    }

}

