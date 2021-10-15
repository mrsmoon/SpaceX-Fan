//
//  RocketsViewController.swift
//  SpaceX Fan
//
//  Created by Sera on 10/14/21.
//

import UIKit

class RocketsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = RocketViewModel()
    var rockets = Rockets()
    
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

extension RocketsViewController: RocketViewModelDelegate {
    func rocketsFetched(_ rockets: Rockets) {
        self.rockets = rockets
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func rocketFetchingDidFail() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Sorry", message: "We are having problem to display SpaceX rockets now. Please try again later.", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            
            self?.present(alert, animated: true, completion: nil)
        }
    }
}

extension RocketsViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: Constants.rocketSegueIdentifier, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.rocketSegueIdentifier {
            if let destinationVC = segue.destination as? RocketDetailViewController {
                //TODO: Send upcoming object here
                //destinationVC.rocket =
            }
        }
    }
}

extension RocketsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.rocketCellIdentifier) as! RocketTableViewCell
        let rocket = rockets[indexPath.row]
        cell.isFavorite = viewModel.isRocketInFavorites(rocket)
        cell.rocket = rocket
        
        cell.starClicked = {
            self.viewModel.updateFavoriteList(withStatusOf: rocket)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rockets.count
    }
}
