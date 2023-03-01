//
//  APODItemViewModel.swift
//  WalEAssignment
//
//  Created by Surya Kant on 01/03/23.
//

import Foundation

struct APODItemViewModel {
    var title: String = ""
    var subTitle: String = ""
    var imageUrlString: String?
    var hdImageUrlString: String = ""

    init(with model: APODItemModel) {
        self.title = model.title
        self.subTitle = model.explanation
        self.imageUrlString = model.urlString
        self.hdImageUrlString = model.hdurlString
    }

}

