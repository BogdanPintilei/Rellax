//
//  AudioPlayer.swift
//  Mindfulness
//
//  Created by Bogdan Pintilei on 7/19/18.
//  Copyright © 2018 Wolfpack. All rights reserved.
//

import UIKit
import Jukebox

class AudioPlayer: NSObject, JukeboxDelegate {

    var jukebox: Jukebox!
    var isReady = Dynamic<Bool>(false)
    var hasStarted = Dynamic<Bool>(false)
    var isPlaying = Dynamic<Bool>(false)
    var isLoading = Dynamic<Bool>(false)

    let totalDuration = Dynamic<TimeInterval>(0.0)
    let currentTime = Dynamic<TimeInterval>(0.0)

    override init() {
        super.init()
    }

    init(
        url: String? = ""
    ) {
        super.init()
        jukebox = Jukebox(delegate: self, items: [JukeboxItem(URL: URL(string: url!)!)])
    }

    func play() {
        switch jukebox.state {
        case .ready:
            jukebox.play(atIndex: 0)
        case .paused:
            jukebox.play()
        default:
            return
        }
    }

    func pause() {
        switch jukebox.state {
        case .playing:
            jukebox.pause()
        default:
            return
        }
    }

    func stop() {
        jukebox.stop()
    }

    func setCurrentTime(value: TimeInterval) {
        jukebox.seek(toSecond: Int(value))
    }

    func jukeboxStateDidChange(_ jukebox: Jukebox) {
        print("jukebox state changed to: \(jukebox.state)")
        if let duration = jukebox.currentItem?.meta.duration {
            self.totalDuration.value = duration
        }
        isReady.value = false
        isPlaying.value = false
        isLoading.value = false
        switch jukebox.state {
        case .ready:
            isReady.value = true
        case .playing:
            isPlaying.value = true
        case .loading:
            isLoading.value = true
        case .paused:
            print("paused")
        case .failed:
            print("failed")
        }
    }

    func jukeboxPlaybackProgressDidChange(_ jukebox: Jukebox) {
        print("playback progres did change")
        self.hasStarted.value = true
        if let currentTime = jukebox.currentItem?.currentTime {
            self.hasStarted.value = false
            self.currentTime.value = currentTime
        }
    }

    func jukeboxDidLoadItem(_ jukebox: Jukebox, item: JukeboxItem) {
        print("jukebox did load item")
    }

    func jukeboxDidUpdateMetadata(_ jukebox: Jukebox, forItem: JukeboxItem) {
        print("jukebox did update metadata")
    }


}


