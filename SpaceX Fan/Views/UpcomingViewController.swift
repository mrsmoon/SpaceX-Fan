//
//  UpcomingViewController.swift
//  SpaceX Fan
//
//  Created by Sera on 10/14/21.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func configureNavigationBar() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.topItem?.title = Constants.favoritesTitle
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Muli-SemiBold", size: 17)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
    }
}
