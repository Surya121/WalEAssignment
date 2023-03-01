//
//  APODResponseParser.swift
//  WalEAssignment
//
//  Created by Surya Kant on 01/03/23.
//

import Foundation

struct APODResponseParser {
    func parseAPODResponse(_ data: Data, onCompletion: (APODItemModel?) -> Void) {
        let decoder = JSONDecoder()
        guard let responseModel = try? decoder.decode(APODItemModel.self, from: data) else {
            onCompletion(nil)
            return
        }
        onCompletion(responseModel)
    }
}
