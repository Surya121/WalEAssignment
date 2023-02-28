//
//  ImageDownloader.swift
//  WalEAssignment
//
//  Created by Surya Kant on 01/03/23.
//

import UIKit
class ImageDownloader {
    func imageFrom(_ urlString: String,
                   completion: @escaping (UIImage?) -> Void) {
        
        if urlString == "" {
            completion(nil)
        } else {
            let escapedAddress = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            let imageName = getImageName(urlString)
            
            if let cachedImage = getImageFromDocumentDirectory(with: imageName) {
                DispatchQueue.main.async {
                    completion(cachedImage)
                }
            } else {
                self.getImageFrom(originalUrl: urlString, url: escapedAddress!, completion: completion)
            }
        }
        
    }

    func getImageFrom(originalUrl: String, url: String, completion: @escaping ( UIImage?) -> Void) {
        if let url = URL(string: url) {
            let session = URLSession.shared
            let downloadTask = session.downloadTask(with: url, completionHandler: { (retrievedURL, _, error) -> Void in
                var found = false
                if error != nil {
                    debugPrint(error?.localizedDescription)
                } else if retrievedURL != nil {
                    if let data = try? Data(contentsOf: retrievedURL!) {
                        if let image = UIImage(data: data) {
                            found = true
                            DispatchQueue.main.async {
                                self.saveImageToDocumentDirectory(image: image, imageName: self.getImageName(originalUrl))
                                completion(image)
                            }
                        }
                    } else {
                        print("Could not load: \(retrievedURL)")
                    }
                }
                if !found {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            })
            downloadTask.resume()
        } else {
            completion(nil)
        }
    }
    func getDirectoryPath() -> String {
        return (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("thumbnailImages")
    }

    func saveImageToDocumentDirectory(image: UIImage, imageName: String) {
        let fileManager = FileManager.default
        let path = getDirectoryPath()
        if !fileManager.fileExists(atPath: path) {
            try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        let url = URL(string: path)
        let imagePath = url!.appendingPathComponent(imageName)
        let urlString: String = imagePath.absoluteString
        let imageData = image.pngData()

        fileManager.createFile(atPath: urlString as String, contents: imageData, attributes: nil)
    }

    func getImageFromDocumentDirectory(with imageName: String) -> UIImage? {
        let fileManager = FileManager.default
        let documentPath = URL(string: self.getDirectoryPath())
        let imagePath = documentPath?.appendingPathComponent(imageName)
        let urlString: String = imagePath!.absoluteString

        if fileManager.fileExists(atPath: urlString) {
            return UIImage(contentsOfFile: urlString)
        } else {
            return nil
        }

    }

    func getImageName(_ url: String) -> String {
        let strings = url.components(separatedBy: "/").suffix(1)
        let originalString = Array(strings).first!
        return removePercentEscapedString(originalString)
    }

    func removePercentEscapedString(_ originalString: String) -> String {
        return originalString.replacingOccurrences(of: "%[0-9a-fA-F]{2}",
                                                   with: "",
                                                   options: .regularExpression,
                                                   range: nil)
    }
}
