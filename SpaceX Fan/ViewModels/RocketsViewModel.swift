//
//  RocketsViewModel.swift
//  SpaceX Fan
//
//  Created by Sera on 10/15/21.
//

import Foundation

protocol RocketViewModelDelegate {
    func rocketsFetched()
    func rocketFetchingDidFail()
}

class RocketViewModel {
    
    func subscribe() {
        //TODO: Add check for cached rockets, if there is no cache call the method below
        fetchRockets()
    }
    
    func unsubscribe() {
        saveFavoriteRockets()
    }
    
    let manager = RocketManager.shared
    var rockets = Rockets()
    
    var favorites: Favorites {
        return manager.getFavoriteRockets()
    }
    
    var delegate: RocketViewModelDelegate?
    
    var selectedRocket: RocketInfo? {
        didSet {
            manager.setCurrentRocket(selectedRocket!)
        }
    }
    
    func saveFavoriteRockets() {
        //TODO: Realm - save
        manager.saveFavorites()
    }
    
    func fetchRockets() {
        manager.getAllRockets { (rockets, error) in
            if let rockets = rockets {
                self.rockets = rockets
                self.delegate?.rocketsFetched()
            } else {
                self.delegate?.rocketFetchingDidFail()
            }
        }
    }
    
    func isRocketInFavorites(_ rocket: RocketInfo) -> Bool  {
        if favorites.contains(rocket) {
            return true
        }
        
        return false
    }
    
    func updateFavoriteList(withStatusOf rocket: RocketInfo) {
        if isRocketInFavorites(rocket) {
            manager.removeFavoriteRocket(rocket)
        } else {
            manager.addFavoriteRocket(rocket)
        }
        
        print(favorites.count)
    }
}
