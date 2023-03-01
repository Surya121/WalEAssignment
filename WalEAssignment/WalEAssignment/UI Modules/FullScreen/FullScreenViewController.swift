//
//  FullScreenViewController.swift
//  WalEAssignment
//
//  Created by Surya Kant on 01/03/23.
//

import UIKit

class FullScreenViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var viewModel: FullScreenViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBarButtonItem()
        self.bindViewModel()
        
    }

    private func bindViewModel() {
        self.viewModel.dataLoaded = { [weak self] image in
            self?.imageView.image = image
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.loadData()

    }

    private func setupNavigationBarButtonItem() {
        let image =  UIImage(named: "backChevron", in: Bundle(for: FullScreenViewController.self), compatibleWith: nil)!
        let customBackButton = UIBarButtonItem(image: image,
                                               style: .plain,
                                               target: self,
                                               action: #selector(backAction(sender:)))
        self.navigationItem.leftBarButtonItem = customBackButton
        self.navigationItem.hidesBackButton = true
    }

    @objc private func backAction(sender: UIBarButtonItem) {
        self.viewModel.backButtonAction()
    }
}
