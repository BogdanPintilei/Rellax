//
//  PlayerViewController.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/3/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import UIKit
import SoundWave
import MediaPlayer
import Kingfisher

class PlayerViewController: UIViewController {

    @IBOutlet var exerciseTitleLabel: UILabel!
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var skipButton: UIButton!
    @IBOutlet var volumeSlider: UISlider!
    @IBOutlet var audioVizualizationSlider: UISlider!
    @IBOutlet var audioVisualizationView: AudioVisualizationView!
    @IBOutlet var currentTimeIndicatorLabel: UILabel!
    @IBOutlet var audioDurationLabel: UILabel!
    @IBOutlet var audioButtonLoadingView: UIView!
    @IBOutlet var previousLongPressGesture: UILongPressGestureRecognizer!
    @IBOutlet var skipLongPressGesture: UILongPressGestureRecognizer!
    @IBOutlet weak var exerciseBackgroundImageView: UIImageView!
    
    var canStart = true

    var exerciseTitleLabelHeroID = ""
    var playButtonHeroID = ""
    var viewHeroID = ""
    var currentTime = TimeInterval(0.0)
    var audioDuration = TimeInterval(0.0)
    var isPlaying = false
    var isLoading = false
    var exercise = Exercise()
    var viewModel = PlayerViewModel()
    let volumeView = MPVolumeView(frame: .zero)
    var timer: Timer!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fillInExerciseData()
        setHeroElementsID()
        initializeAudioManager()
        hideAudioHUD()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
        playOrPauseAudio()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initializeViewModel()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deinitializeVC()
    }

    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func play(_ sender: Any) {
        playOrPauseAudio()
    }

    @IBAction func playNext(_ sender: Any) {
        currentTime + GlobalVariables.playerProgress <= audioDuration ? setAudioTime(at: currentTime + GlobalVariables.playerProgress) : setAudioTime(at: audioDuration - 1)
        audioVizualizationSlider.isSelected = false
    }

    @IBAction func playNextLongPress(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            beginForwardPress()
        case .ended:
            endPress()
        default:
            break
        }
    }

    @IBAction func playPrevious(_ sender: Any) {
        currentTime - GlobalVariables.playerProgress > 0 ? setAudioTime(at: currentTime - GlobalVariables.playerProgress) : setAudioTime(at: 0)
        audioVizualizationSlider.isSelected = false
    }

    @IBAction func previousLongPress(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            beginPreviousPress()
        case .ended:
            endPress()
        default:
            break
        }
    }

    @IBAction func setAudioVizualizerValue(_ sender: Any) {
        audioVizualizationSlider.isSelected = true
        setAudioVizualizerTime(at: TimeInterval(audioVizualizationSlider.value))
    }

    @IBAction func finishSlidingAudioVizualizer(_ sender: UISlider) {
        viewModel.setCurrentTime(value: Double(audioVizualizationSlider.value))
        audioVizualizationSlider.isSelected = false
    }

    @IBAction func setVolume(_ sender: Any) {
        viewModel.setVolume(value: volumeSlider.value)
    }

    private func customizeUI() {
        initializeSoundWave()
        playButton.setRoundFrame()
        customizeVolumeSlider()
        exerciseBackgroundImageView.kf.setImage(with: URL(string: exercise.imageURL!))
        exerciseBackgroundImageView.addBlurEffect(withStyle: .light)
    }

    private func customizeVolumeSlider() {
        let sliderImage = UIImage.circle(diameter: GlobalVariables.sliderHeight, color: UIColor.AppColors.blue)
        volumeSlider.setThumbImage(sliderImage, for: .normal)
        volumeSlider.setThumbImage(sliderImage, for: .highlighted)
    }

    private func fillInExerciseData() {
        exerciseTitleLabel.text = exercise.title
    }

    private func playOrPauseAudio() {
        viewModel.playOrPauseAudio()
        if !canStart {
            !isPlaying ? audioVisualizationView.pause() : audioVisualizationView.play(for: audioDuration)
        }
    }

    private func hideAudioHUD() {
        UIApplication.shared.keyWindow?.insertSubview(volumeView, at: 0)
    }

    private func showOrHideAudioLoading(state: Bool) {
        state ? LoadingView.startLoadingAnimation(indicatorType: .audio, view: self.audioButtonLoadingView) : LoadingView.stopLoadingAnimation(indicatorType: .audio)
        audioButtonLoadingView.isHidden = !state
        setButtonImage()
    }
    
    private func progressForward() {
        currentTime + GlobalVariables.playerProgress <= audioDuration ? setAudioTime(at: currentTime + GlobalVariables.playerProgress) : setAudioTime(at: audioDuration - 1)
        audioVizualizationSlider.isSelected = false
    }
    
    private func progressBackward() {
        currentTime - GlobalVariables.playerProgress > 0 ? setAudioTime(at: currentTime - GlobalVariables.playerProgress) : setAudioTime(at: 0)
        audioVizualizationSlider.isSelected = false
    }


}

// MARK: - Initializers

extension PlayerViewController {

    private func initializeVC() {
        customizeUI()
    }

    private func initializeViewModel() {
        viewModel.initializeAudio(audioURL: exercise.audioURL!, title: exercise.title!)
        bindViewModel()
    }

    private func initializeAudioManager() {
        AudioManager.shared.listenVolumeButtons()
        AudioManager.shared.volume.bindAndFire { [weak self] (volume) in
            guard let `self` = self else { return }
            self.volumeSlider.value = volume
        }
    }

    private func initializeSoundWave() {
        audioVizualizationSlider.minimumValue = 0
        audioVizualizationSlider.maximumValue = Float(exercise.duration! - 0.05)
        self.audioDurationLabel.text = PlayerHelper().getCurrentTimeLabel(from: Int(self.exercise.duration!))
        audioVizualizationSlider.value = 0.0
        audioVisualizationView.meteringLevelBarWidth = 2.4
        audioVisualizationView.meteringLevelBarInterItem = 1.5
        audioVisualizationView.meteringLevelBarCornerRadius = 0.0
        audioVisualizationView.gradientStartColor = UIColor.AppColors.transparency75White
        audioVisualizationView.gradientEndColor = UIColor.AppColors.blue
        audioVisualizationView.audioVisualizationMode = .read
        audioVisualizationView.shouldDisplayBlock = true
        audioVisualizationView.meteringLevels = viewModel.handle(meteringLevels: exercise.meteringLevels!)
    }

    private func deinitializeVC() {
        volumeView.removeFromSuperview()
        AudioManager.shared.deinititalize()
        viewModel.deinitializeAudio()
    }


    private func beginPreviousPress() {
        timer = Timer.scheduledTimer(timeInterval: 0.006, target: self, selector: #selector(runPreviousAction), userInfo: nil, repeats: true)
    }

    private func beginForwardPress() {
        timer = Timer.scheduledTimer(timeInterval: 0.006, target: self, selector: #selector(runForwardAction), userInfo: nil, repeats: true)
    }

    private func endPress() {
        timer.invalidate()
        skipLongPressGesture.isEnabled = true
        previousLongPressGesture.isEnabled = true
    }

    @objc func runPreviousAction() {
        currentTime - 1 > 0 ? setAudioTime(at: currentTime - 1) : setAudioTime(at: 0)
        skipLongPressGesture.isEnabled = false
    }

    @objc func runForwardAction() {
        currentTime + 1 <= audioDuration ? setAudioTime(at: currentTime + 1) : setAudioTime(at: 0)
        previousLongPressGesture.isEnabled = false
    }

}

// MARK: - UI Setters

extension PlayerViewController {

    private func setAudioTime(at time: TimeInterval) {
        setAudioVizualizerTime(at: time)
        viewModel.setCurrentTime(value: time)
    }

    private func setAudioVizualizerTime(at time: TimeInterval) {
        setAudioVizualizerPosition(at: time)
        currentTimeIndicatorLabel.text = PlayerHelper().getCurrentTimeLabel(from: Int(time))
    }

    private func setAudioVizualizerPosition(at value: TimeInterval) {
        if !canStart {
            viewModel.isPlaying.value ? audioVisualizationView.pause() : audioVisualizationView.play(for: audioDuration)
            audioVisualizationView.play(from: value, fromTotalDuration: audioDuration, shouldContinuePlaying: viewModel.isPlaying.value)
            if !viewModel.isPlaying.value { audioVisualizationView.pause() }
            audioVizualizationSlider.isSelected = true
        }
    }

    private func setHeroElementsID () {
        exerciseTitleLabel.hero.id = exerciseTitleLabelHeroID
        playButton.hero.id = playButtonHeroID
        self.view.hero.id = viewHeroID
    }

    private func setButtonImage() {
        self.playButton.setImage(isPlaying ? #imageLiteral(resourceName: "pause"): #imageLiteral(resourceName: "play"), for: .normal)
        if isLoading { self.playButton.setImage(UIImage(), for: .normal) }
    }

}

// MARK: - Binding

extension PlayerViewController {

    private func bindViewModel() {

        viewModel.totalDuration.bind { [weak self] (duration) in
            guard let `self` = self else { return }
            self.audioDuration = duration
            self.audioDurationLabel.text = PlayerHelper().getCurrentTimeLabel(from: Int(duration))
            self.audioVizualizationSlider.maximumValue = Float(duration - 0.05)
        }

        viewModel.currenTime.bind { [weak self] (currentTime) in
            guard let `self` = self else { return }
            self.currentTime = currentTime
            self.audioVizualizationSlider.value = Float(currentTime)
            if !self.audioVizualizationSlider.isSelected {
                self.currentTimeIndicatorLabel.text = PlayerHelper().getCurrentTimeLabel(from: Int(self.currentTime))
            }
            let areButtonsEnabled = (currentTime < self.audioDuration - 3)
            self.playButton.isEnabled = areButtonsEnabled
            self.previousButton.isEnabled = areButtonsEnabled
            self.skipButton.isEnabled = areButtonsEnabled
        }

        viewModel.isPlaying.bindAndFire { [weak self] (isPlaying) in
            guard let `self` = self else { return }
            self.isPlaying = isPlaying
            self.setButtonImage()
        }

        viewModel.isLoading.bind { [weak self] (isLoading) in
            guard let `self` = self else { return }
            self.isLoading = isLoading
            self.showOrHideAudioLoading(state: isLoading)
        }

        viewModel.hasStarted.bind { [weak self] (hasStarted) in
            guard let `self` = self else { return }
            if hasStarted && self.canStart && self.currentTime > 0 {
                self.audioVisualizationView.play(for: self.audioDuration)
                self.canStart = false
            }
        }

        viewModel.isReady.bind { [weak self] (isReady) in
            guard let `self` = self else { return }
            if isReady {
                self.initializeViewModel()
                self.audioVisualizationView.reset()
                self.initializeSoundWave()
                self.canStart = true
            }
        }
    }

}

// Track remote control events

extension PlayerViewController {
    
    override func remoteControlReceived(with event: UIEvent?) {
        if event?.type == .remoteControl {
            switch event!.subtype {
            case .remoteControlPlay:
                viewModel.playOrPauseAudio()
            case .remoteControlPause:
                viewModel.playOrPauseAudio()
            case .remoteControlNextTrack:
                viewModel.playOrPauseAudio()
                progressForward()
                viewModel.playOrPauseAudio()
            case .remoteControlPreviousTrack:
                viewModel.playOrPauseAudio()
                progressBackward()
                viewModel.playOrPauseAudio()
            default:
                break
            }
        }
    }
    
}

