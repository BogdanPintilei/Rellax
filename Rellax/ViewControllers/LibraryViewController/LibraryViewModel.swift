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
    var isEmpty:Bool {
        return exerciseList.isEmpty
    }
    var numberOfExercises: Int {
        return exerciseList.count
    }
    
    private var exerciseList = [Exercise]()

    func loadExerciseList() {
        isLoading.value = true
        LoadingView.startLoadingAnimation(indicatorType: .regular)
        APIClient.getExerciseList { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let exerciseList):
                self.exerciseList = exerciseList
            }
            LoadingView.stopLoadingAnimation(indicatorType: .regular)
            self.isLoading.value = false
        }
    }

    func itemAt(index: Int) -> Exercise {
        return index < numberOfExercises ?  exerciseList[index] :  Exercise()
    }
    
}
