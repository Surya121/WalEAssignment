//
//  APODViewModel.swift
//  WalEAssignment
//
//  Created by Surya Kant on 28/02/23.
//

import UIKit

final class APODViewModel {
    private var manager: PlanetaryAPODManager
    var dataLoaded: ((APODItemViewModel?) -> Void)?
    var showFullScreen: ((APODItemViewModel?) -> Void)?
    var coordinator: HomeCoordinator?

    init (manager: PlanetaryAPODManager, coordinator: HomeCoordinator) {
        self.manager = manager
        self.coordinator = coordinator
    }

    func loadAPODData() {
        self.manager.getAPODData(date: Date()) { statusCode, model in
            if let model {
                let viewModel = APODItemViewModel(with: model)
                self.dataLoaded?(viewModel)
            } else {
                self.showPreviousDataIfFound()
            }
        } onFailure: { error in
            self.showPreviousDataIfFound()
        }
    }


    func showPreviousDataIfFound() {

    }

}
