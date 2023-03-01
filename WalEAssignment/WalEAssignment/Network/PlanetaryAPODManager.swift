//
//  PlanetaryAPODManager.swift
//  WalEAssignment
//
//  Created by Surya Kant on 01/03/23.
//

import Foundation

class PlanetaryAPODManager {

    var dataTask: URLSessionDataTask?
    let defaultSession = URLSession(configuration: .default)

    func getAPODData(date: Date,
                     onSuccess: @escaping (_ statusCode: Int, _ models: APODItemModel?) -> Void,
                     onFailure: @escaping (_ error: Error) -> Void) {

        let urlString = Constants.NetworkTansactions.baseURL
        let apiKey = Constants.NetworkTansactions.apiKey
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: urlString) {
            urlComponents.query = "api_key=\(apiKey)"


            guard let url = urlComponents.url else {
                return
            }

            dataTask = defaultSession.dataTask(with: url, completionHandler: { [weak self] data, response, error in
                defer {
                    self?.dataTask = nil
                }

                if let _ = error {
                } else if
                  let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 {
                  DispatchQueue.main.async {
                      APODResponseParser().parseAPODResponse(data) { model in
                          onSuccess(response.statusCode, model)
                      }
                  }
                }
            })
        }
        dataTask?.resume()
    }

}
