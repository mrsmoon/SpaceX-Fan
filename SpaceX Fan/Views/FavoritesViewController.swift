//
//  FavoritesViewController.swift
//  SpaceX Fan
//
//  Created by Sera on 10/14/21.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.subscribe()
        tableView.reloadData()
        configureNavigationBar()
        title = Constants.favoritesTitle
    }

    override func viewWillDisappear(_ animated: Bool) {
        viewModel.unsubscribe()
    }
    
    let viewModel = FavoritesViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.favoritesTitle
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 180
    }
    
    func configureNavigationBar() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.topItem?.title = Constants.favoritesTitle
        let attributes = [NSAttributedString.Key.font: UIFont(name: Constants.muliSemibold, size: 17)!,
                          NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    @IBAction func tabBarClicked(_ sender: UIButton) {
        if sender.tag == 0 {
            let story = UIStoryboard(name: Constants.mainStoryboard, bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: Constants.rocketsStoryboardId)
                    
            navigationController?.pushViewController(vc, animated: false)
            
        } else if sender.tag == 2 {
            let story = UIStoryboard(name: Constants.mainStoryboard, bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: Constants.upcomingStoryboardId)
                    
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}

//MARK: - UITableViewDelegate

extension FavoritesViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectedRocket = viewModel.currentFavorites?[indexPath.row]
        
        performSegue(withIdentifier: Constants.favoriteSegueIdentifier, sender: self)
    }
}

//MARK: - UITableViewDataSource

extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.rocketCellIdentifier) as! RocketTableViewCell
        
        let rocket = viewModel.currentFavorites![indexPath.row]
        cell.isFavorite = viewModel.isRocketInFavorites(rocket)
        
        cell.rocket = rocket
        
        cell.starClicked = {
            self.viewModel.updateFavoriteList(withStatusOf: rocket)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currentFavorites?.count ?? 0
    }
}
