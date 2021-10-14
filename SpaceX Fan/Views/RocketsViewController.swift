//
//  RocketsViewController.swift
//  SpaceX Fan
//
//  Created by Sera on 10/14/21.
//

import UIKit

class RocketsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.topItem?.title = Constants.rocketsTitle
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Muli-SemiBold", size: 17)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
    }
    
    @IBAction func tabBarClicked(_ sender: UIButton) {
        if sender.tag == 1 {
            let story = UIStoryboard(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: Constants.favoritesStoryboardId)
                    
            navigationController?.pushViewController(vc, animated: false)
            
        } else if sender.tag == 2 {
            let story = UIStoryboard(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: Constants.upcomingStoryboardId)
                    
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}

extension RocketsViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension RocketsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.rocketCellIdentifier) as! RocketTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}
