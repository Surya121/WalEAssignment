//
//  BaseViewController.swift
//  WalEAssignment
//
//  Created by Surya Kant on 28/02/23.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
    }

    private func configureNavigationBar() {
        let image =  UIImage(named: "backChevron", in: Bundle(for: BaseViewController.self), compatibleWith: nil)!

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = .blue
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        self.navigationController?.navigationBar.backIndicatorImage = image
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .white
    }

}
