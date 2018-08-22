//
//  Dynamic.swift
//  Mindfulness
//
//  Created by Bogdan Pintilei on 7/10/18.
//  Copyright © 2018 Wolfpack. All rights reserved.
//

import Foundation

class Dynamic<T> {
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    init(_ v: T) {
        value = v
    }
    
}
