//
//  APODItemViewModel.swift
//  WalEAssignment
//
//  Created by Surya Kant on 01/03/23.
//

import Foundation

struct APODItemViewModel: Codable {
    var title: String = ""
    var subTitle: String = ""
    var imageUrlString: String?
    var hdImageUrlString: String?
    var imageUrlStringPath: String?
    var hdImageUrlStringPath: String?

    private enum CodingKeys: String, CodingKey {
        case title
        case subTitle
        case imageUrlString
        case hdImageUrlString
        case imageUrlStringPath
        case hdImageUrlStringPath
    }

    init(with model: APODItemModel) {
        self.title = model.title
        self.subTitle = model.explanation
        self.imageUrlString = model.urlString
        self.hdImageUrlString = model.hdurlString
    }

}

class APODLoader {
  static private var plistURL: URL {
    let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documents.appendingPathComponent("apod.plist")
  }

  static func load() -> APODItemViewModel? {
    let decoder = PropertyListDecoder()

    guard let data = try? Data.init(contentsOf: plistURL),
      let preferences = try? decoder.decode(APODItemViewModel.self, from: data)
      else { return nil }

    return preferences
  }

    static func copyPlistFromBundle() {
        if let path = Bundle.main.path(forResource: "apod", ofType: "plist"),
          let data = FileManager.default.contents(atPath: path),
          FileManager.default.fileExists(atPath: plistURL.path) == false {

          FileManager.default.createFile(atPath: plistURL.path, contents: data, attributes: nil)
        }
      }

    static func write(model: APODItemViewModel) {
        let encoder = PropertyListEncoder()

        if let data = try? encoder.encode(model) {
          if FileManager.default.fileExists(atPath: plistURL.path) {
            // Update an existing plist
            try? data.write(to: plistURL)
          } else {
            // Create a new plist
            FileManager.default.createFile(atPath: plistURL.path, contents: data, attributes: nil)
          }
        }
      }
}

