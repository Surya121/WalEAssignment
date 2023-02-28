//
//  HomeCoordinator.swift
//  WalEAssignment
//
//  Created by Surya Kant on 01/03/23.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    func getNavigationController() -> UINavigationController?
}

final class HomeCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController?

    init() {

    }

    func generateAPODScreen() -> UIViewController {
        let controller = Storyboardable<APODViewController>.main.instantiate
        let viewModel = APODViewModel()
        controller.viewModel = viewModel
        return controller
    }

    func getNavigationController() -> UINavigationController? {
        self.navigationController
    }
}
