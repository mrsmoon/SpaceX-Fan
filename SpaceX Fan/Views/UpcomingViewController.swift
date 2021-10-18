//
//  UpcomingViewController.swift
//  SpaceX Fan
//
//  Created by Sera on 10/14/21.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = UpcomingViewModel.shared
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.subscribe()
        configureNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
    }
    
    func configureNavigationBar() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.topItem?.title = Constants.upcomingTitle
        let attributes = [NSAttributedString.Key.font: UIFont(name: Constants.muliSemibold, size: 17)!,
                          NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    @IBAction func tabBarClicked(_ sender: UIButton) {
        if sender.tag == 0 {
            let story = UIStoryboard(name: Constants.mainStoryboard, bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: Constants.rocketsStoryboardId)
                    
            navigationController?.pushViewController(vc, animated: false)
            
        } else if sender.tag == 1 {
            getFaceIDAuthorization()
        }
    }
}

extension UpcomingViewController: UpcomingViewModelDelegate {
    func upcomingsFetched() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension UpcomingViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension UpcomingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.upcomingCellIdentifier) as! UpcomingTableViewCell
        
        let upcomingLaunch = viewModel.upcomings[indexPath.row]
        
        cell.exploreClicked = {
            self.viewModel.selectedUpcoming = upcomingLaunch
            self.performSegue(withIdentifier: Constants.upcomingSegueIdentifier, sender: self)
        }
        
        cell.populateCell(with: upcomingLaunch, isCellIndexEven: indexPath.row.isMultiple(of: 2))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.upcomings.count
    }
}

