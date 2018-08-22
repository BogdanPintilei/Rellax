//
//  LibraryViewController2.swift
//  Mindfulness
//
//  Created by Bogdan Pintilei on 7/5/18.
//  Copyright © 2018 Wolfpack. All rights reserved.
//

import UIKit
import CHIPageControl

class LibraryViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControlView: UIView!
    @IBOutlet var pageControlViewWidthContraint: NSLayoutConstraint!
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!

    var viewModel = LibraryViewModel()
    let pageControl = CHIPageControlPuya(frame: CGRect.zero)

    private var collectionViewFlowLayout: UICollectionViewFlowLayout {
        return collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getExercises()
        bindViewModel()
    }

    @IBAction func showPreviousCard(_ sender: Any) {
        previousButton.animateButton()
        scroll(isDirectionForward: false)
    }

    @IBAction func showNextCard(_ sender: Any) {
        nextButton.animateButton()
        scroll(isDirectionForward: true)
    }

    private func scroll(isDirectionForward: Bool) {
        var index = indexOfMajorCell()
        if isDirectionForward {
            index = viewModel.numberOfExercises - 1 > indexOfMajorCell() ? indexOfMajorCell() + 1 : indexOfMajorCell()
        } else {
            index = viewModel.numberOfExercises > 1 && indexOfMajorCell() != 0 ? indexOfMajorCell() - 1: indexOfMajorCell()
        }
        let indexPath = IndexPath(row: index, section: 0)
        pageControl.set(progress: index, animated: true)
        if !viewModel.isEmpty { collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true) }
    }

    private func getExercises() {
        viewModel.loadExerciseList()
    }

    private func bindViewModel() {
        viewModel.isLoading.bind { isLoading in
            if !isLoading {
                UIView.transition(with: self.collectionView,
                                  duration: 0.35,
                                  options: UIViewAnimationOptions.transitionCrossDissolve,
                                  animations: { self.collectionView.reloadData() })
                self.addCustomPageController(numberOfPages: self.viewModel.numberOfExercises)
                self.shouldHideControllButtons(status: false)
            }
        }
    }

    private func addCustomPageController(numberOfPages: Int) {
        pageControl.numberOfPages = numberOfPages
        pageControl.radius = GlobalVariables.pageControlRadius
        pageControl.padding = GlobalVariables.pageControlRadius
        pageControl.tintColor = UIColor.AppColors.transparency50White
        pageControl.currentPageTintColor = UIColor.white
        pageControlViewWidthContraint.constant = pageControl.intrinsicContentSize.width
        pageControlView.frame.size.width = pageControlViewWidthContraint.constant
        pageControl.center = pageControlView.convert(pageControlView.center, from: pageControl)
        pageControlView.addSubview(pageControl)
    }

    private func indexOfMajorCell() -> Int {
        let itemWidth = collectionViewFlowLayout.itemSize.width
        let proportionalOffset = collectionView!.contentOffset.x / itemWidth
        return Int(round(proportionalOffset))
    }

    private func shouldHideControllButtons(status: Bool) {
        previousButton.isHidden = status
        nextButton.isHidden = status
    }

}

// MARK: CollectionView Delegate & DataSource

extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfExercises
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.library.cell, for: indexPath) as! ExerciseCollectionViewCell
        cell.exercise = viewModel.itemAt(index: indexPath.row)
        cell.exerciseView.delegate = self
        cell.exerciseView.heroIDIndex = indexPath.row

        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.frame.size.width - GlobalVariables.libraryCardMargin * 2
        let height = self.collectionView.frame.size.height
        collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, GlobalVariables.libraryCardMargin, 0, GlobalVariables.libraryCardMargin)
        return CGSize(width: width, height: height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.set(progress: indexOfMajorCell(), animated: true)
    }

}

// MARK: Exercise View Delegate

extension LibraryViewController: ExerciseViewDelegate {

    func showInformationFlow(exerciseID: Int) {
        Navigator.shared.showInformationFlow(from: self, exerciseID: exerciseID)
    }

    func showPlayerScreen() {
        let exercise = viewModel.itemAt(index: indexOfMajorCell())
        Navigator.shared.presentPlayer (
            from: self,
            exercise: exercise,
            labelHeroID: HeroIDGenerator.libraryExerciseTitleHeroID(id: indexOfMajorCell()),
            letsRollButtonHeroID: HeroIDGenerator.libraryButtonTitleHeroID(id: indexOfMajorCell()),
            viewHeroID: HeroIDGenerator.libraryViewHeroID(id: indexOfMajorCell())
        )
    }

}

