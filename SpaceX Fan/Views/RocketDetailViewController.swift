//
//  RocketDetailViewController.swift
//  SpaceX Fan
//
//  Created by Sera on 10/14/21.
//

import UIKit

class RocketDetailViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Constants.rocketsTitle
    }
    
    func configureNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.backBarButton, style: .plain, target: self, action: #selector(backTapped))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.topItem?.title = Constants.rocketsTitle
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Muli-SemiBold", size: 17)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
    }
    
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }

}
