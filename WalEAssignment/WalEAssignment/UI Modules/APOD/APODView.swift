//
//  APODView.swift
//  WalEAssignment
//
//  Created by Surya Kant on 01/03/23.
//

import UIKit

class APODView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    var tapCompletion: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureView()
    }

    func configureView() {
        self.imageView.image = nil
        self.explanationLabel.text = ""
        self.titleLabel.text = ""
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:)))
        self.imageView.addGestureRecognizer(tapGestureRecognizer)
    }

    func configure(using model: APODItemViewModel?, completion: @escaping (() -> Void)) {
        if let url = model?.imageUrlString {
            ImageDownloader().imageFrom(url) { [weak self] image in
                if url == model?.imageUrlString {
                    self?.imageView.image = image
                } else {
                self?.imageView.image = nil
            }
            }
        }
        self.titleLabel.text = model?.title
        self.explanationLabel.text = model?.subTitle
        self.tapCompletion = completion
    }

    @IBAction func didTapImageView(_ sender: UITapGestureRecognizer) {
        self.tapCompletion?()
    }
}
