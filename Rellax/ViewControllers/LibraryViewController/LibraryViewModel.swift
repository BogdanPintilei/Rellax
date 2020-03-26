//
//  LibraryViewModel2.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/5/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import Foundation
import Kingfisher

class LibraryViewModel {
    
    var isLoading = Dynamic(false)
    var contentWasLoaded = false
    var isEmpty: Bool {
        return exerciseList.isEmpty
    }
    
    var numberOfExercises: Int {
        return exerciseList.count
    }
    
    private var exerciseList = [Track]()
    
    func loadExerciseList() {
        if !contentWasLoaded {
            isLoading.value = true
            LoadingView.startLoadingAnimation(indicatorType: .regular)
            APIClient.getExerciseList { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let exerciseList):
                    self.exerciseList = exerciseList.reversed()
                }
                LoadingView.stopLoadingAnimation(indicatorType: .regular)
                self.isLoading.value = false
                self.contentWasLoaded = true
            }
        }
    }
    
    func itemAt(index: Int) -> Track {
        return index < numberOfExercises ? exerciseList[index] : Track()
    }
    
}
