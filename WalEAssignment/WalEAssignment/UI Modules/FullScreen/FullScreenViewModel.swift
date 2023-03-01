//
//  FullScreenViewModel.swift
//  WalEAssignment
//
//  Created by Surya Kant on 01/03/23.
//

import UIKit

final class FullScreenViewModel {
    private var model:APODItemViewModel
    var dataLoaded: ((UIImage?) -> Void)?
    var popBack: (() -> Void)?

    init (model: APODItemViewModel) {
        self.model = model
    }

    func loadData() {
        UIImage.loadImageUsingCacheWithUrlString(self.model.hdImageUrlString) { [weak self] image in
            self?.dataLoaded?(image)
        }
    }

    func backButtonAction() {
        self.popBack?()
    }
}
