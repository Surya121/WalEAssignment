//
//  Storyboardable.swift
//  WalEAssignment
//
//  Created by Surya Kant on 01/03/23.
//

import UIKit

enum Storyboardable<ViewController> {
    case main

    var storyboardName: String {
        switch self {
        case .main:
            return "Main"
        }
    }

    var instantiate: ViewController {
        let storyboard = UIStoryboard(name: self.storyboardName, bundle: BundleClass.bundle)
        return storyboard.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as! ViewController
    }
}

class BundleClass {
    static let bundle = Bundle(for: BundleClass.self)
}
