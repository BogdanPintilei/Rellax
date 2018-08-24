//
//  SegueHandler.swift
//  Rellax
//
//  Created by Bogdan Pintilei on 7/2/18.
//  Copyright © 2018 Bogdan. All rights reserved.
//

import UIKit

// Protocol to be adapted by every UIViewController which woks with segue. Each of these UIViewController must declare an enum of type SegueIdentifier in which to declare the identifiers of each segue.

public protocol SegueHandler {
    associatedtype SegueIdentifier: RawRepresentable
}

// Default impementation of the method defined in the protocol above.
extension SegueHandler where Self: UIViewController, SegueIdentifier.RawValue == String {
    
    public func segueIdentifier(for segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier,
            let segueIdentifier  = SegueIdentifier(rawValue: identifier)
            else { fatalError("Unknown segue \(segue)")}
        return segueIdentifier
    }
    
    public func performSegue(withIdentifier segueIdentifier: SegueIdentifier) {
        performSegue(withIdentifier: segueIdentifier.rawValue, sender: nil)
    }
    
}
