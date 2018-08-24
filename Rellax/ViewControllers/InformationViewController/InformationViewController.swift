//
//  InformationViewController.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/3/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var loadingView: UIView!

    var viewModel = InformationViewModel()
    var exerciseID = 0

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
        initializeViewModel()
        setupCollectionView()
    }

    @IBAction func dismiss(_ sender: Any) {
        LoadingView.stopLoadingAnimation(indicatorType: .regular)
        self.dismiss(animated: true, completion: nil)
    }

    private func customizeUI() {
        self.setNavigationBarTransparent()
        self.setNavigationBarFont(ofSize: GlobalVariables.navigationBarFontSize, andWeight: .bold, ofColor: .white)
    }

    private func initializeViewModel() {

        viewModel.getFacts(exerciseID: exerciseID)
        bindViewModel()
        LoadingView.startLoadingAnimation(indicatorType: .regular, view: loadingView)
    }

    private func bindViewModel() {
        viewModel.isLoading.bind { isLoadig in
            if !isLoadig {
                UIView.transition(with: self.collectionView,
                    duration: 0.7,
                    options: .transitionFlipFromRight,
                    animations: { self.collectionView.reloadData() })
                LoadingView.stopLoadingAnimation(indicatorType: .regular)
            }
        }
    }

    private func setupCollectionView() {
        let nib = UINib.init(nibName: InformationCollectionViewCell.nibName, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: Cells.information.cell)
    }

}

// MARK: Collection View Delegate & Data Source

extension InformationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfFacts
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height / 2.5
        let width = indexPath.row == 0 && viewModel.isDatasourceCountEven ? collectionView.frame.width : collectionView.frame.width / 2 - GlobalVariables.informationCellsSpacing
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.information.cell, for: indexPath) as! InformationCollectionViewCell
        cell.information = viewModel.factAt(index: indexPath.row)
        cell.heroIDIndex = indexPath.row
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Navigator.shared.showInformationDetails (
            from: self,
            exerciseInformation: viewModel.factAt(index: indexPath.row),
            informationTitleLabelHeroID: HeroIDGenerator.informationTitleLabelHeroID(id: indexPath.row),
            viewHeroID: HeroIDGenerator.informationDetailsViewHeroID(id: indexPath.row)
        )
    }

}
