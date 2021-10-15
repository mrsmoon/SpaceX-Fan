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

        //TODO: Change title according to rocket name
        title = "FALCON 9"
    }
    
    func configureNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.backBarButton, style: .plain, target: self, action: #selector(backTapped))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.topItem?.title = Constants.rocketsTitle
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: Constants.nasalizationFont, size: 16)!,
             NSAttributedString.Key.foregroundColor: UIColor.exploreButtonBorderColor]
    }
    
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }

}
