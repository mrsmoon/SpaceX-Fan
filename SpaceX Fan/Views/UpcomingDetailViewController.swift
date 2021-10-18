//
//  UpcomingDetailViewController.swift
//  SpaceX Fan
//
//  Created by Sera on 10/14/21.
//

import UIKit
import Firebase

class UpcomingDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = UpcomingDetailViewModel.shared
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.subscribe()
        configureNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.upcomingTitle

        tableView.delegate = self
        tableView.dataSource = self
        
        Analytics.logEvent(Constants.logEvent4,
                           parameters: ["upcoming_launch": viewModel.currentUpcoming?.getName() ?? ""])
    }
    
    func configureNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.backBarButton, style: .plain, target: self, action: #selector(backTapped))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.topItem?.title = Constants.upcomingTitle
        let attributes = [NSAttributedString.Key.font: UIFont(name: Constants.muliSemibold, size: 17)!,
                          NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension UpcomingDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.upcomingDetailCellIdentifier) as! UpcomingDetailTableViewCell

        if let upcoming = viewModel.currentUpcoming {
            cell.upcoming = upcoming
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
}
