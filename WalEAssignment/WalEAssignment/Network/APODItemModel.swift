//
//  APODItemModel.swift
//  WalEAssignment
//
//  Created by Surya Kant on 01/03/23.
//

import Foundation

struct APODItemModel: Decodable {
    var copyright: String = ""
    var title: String = ""
    var explanation: String = ""
    var date: Date = Date()
    var hdurlString: String = ""
    var urlString: String = ""
    var mediaType: String = ""
    var serviceVersion: String = ""
    enum CodingKeys: String, CodingKey {
        case copyright = "copyright"
        case title = "title"
        case explanation = "explanation"
        case date = "date"
        case hdurlString = "hdurl"
        case urlString = "url"
        case mediaType = "media_type"
        case serviceVersion = "service_version"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.copyright = try container.decode(String.self, forKey: .copyright)
        self.title = try container.decode(String.self, forKey: .title)
        self.explanation = try container.decode(String.self, forKey: .explanation)
        self.hdurlString = try container.decode(String.self, forKey: .hdurlString)
        self.urlString = try container.decode(String.self, forKey: .urlString)
    }

}
