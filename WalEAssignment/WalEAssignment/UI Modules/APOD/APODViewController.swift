//
//  ViewController.swift
//  WalEAssignment
//
//  Created by Surya Kant on 28/02/23.
//

import UIKit

protocol NibProtocol {
    static var nib: UINib? { get }
}
extension UIView: NibProtocol {
    static var nib: UINib? {
        UINib(nibName: String(describing: self), bundle: nil)
    }
}

final class APODViewController: UIViewController {
    lazy var apodView: APODView = {
        APODView.nib?.instantiate(withOwner: APODView.self,
                                              options: nil).first as! APODView
    }()

    var viewModel: APODViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.loadAPODData()
    }

    private func setUpUI() {

    }

    private func bindViewModel() {
        self.viewModel.dataLoaded = { [weak self] model in
            guard let weakSelf = self else { return }
            if let model {
                weakSelf.view.addSubview(weakSelf.apodView)
                weakSelf.apodView.configure(using: model) { [weak self] in
                    self?.viewModel.showFullScreen?(model)
                }
            }
        }
    }
}

