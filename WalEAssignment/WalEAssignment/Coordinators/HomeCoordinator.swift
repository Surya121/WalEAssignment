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

final class HomeCoordinator {
    let manager: PlanetaryAPODManager
    private weak var navigationController: UINavigationController?

    init() {
        self.manager = PlanetaryAPODManager()
    }

    deinit {
        print("self is deinitialize()")
    }

    func generateAPODScreen() -> UINavigationController? {
        let controller = Storyboardable<APODViewController>.main.instantiate
        let viewModel = APODViewModel(manager: self.manager, coordinator: self)
        viewModel.showFullScreen = { [weak self] model in
            self?.navigateToFullScreen(model: model)
        }
        controller.viewModel = viewModel
        self.navigationController = UINavigationController(rootViewController: controller)
        return self.navigationController
    }

    func navigateToFullScreen(model: APODItemViewModel?) {
        if let model {
            let controller = Storyboardable<FullScreenViewController>.main.instantiate
            let viewModel = FullScreenViewModel(model: model)
            viewModel.popBack = { [weak self] in
                self?.getNavigationController()?.popViewController(animated: true)
            }
            controller.viewModel = viewModel
            self.getNavigationController()?.pushViewController(controller, animated: true)
        }

    }


}

extension HomeCoordinator: CoordinatorProtocol {
    func getNavigationController() -> UINavigationController? {
        self.navigationController
    }
}
