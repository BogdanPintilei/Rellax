//
//  InformationViewModel.swift
//  Mindfulness
//
//  Created by Bogdan Pintilei on 7/3/18.
//  Copyright © 2018 Wolfpack. All rights reserved.
//

import Foundation

class InformationViewModel {

    var isLoading = Dynamic(true)
    var numberOfFacts: Int {
        return facts.count
    }
    var isDatasourceCountEven: Bool {
        return facts.count % 2 != 0
    }

    private var facts = [Fact]()

    func getFacts(exerciseID: Int) {
        isLoading.value = true
        APIClient.getFacts(exerciseID: exerciseID) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let facts):
                self.facts = facts
            }
            self.isLoading.value = false
        }
    }

    func factAt(index: Int) -> Fact {
        return index < numberOfFacts ? facts[index] : Fact()
    }

}
