//
//  FavoritesViewModel.swift
//  SpaceX Fan
//
//  Created by Sera on 10/15/21.
//

import Foundation

class FavoritesViewModel {
    
    func subscribe() {
        getFavorites()
    }
    
    func unsubscribe() {
        saveFavoriteRockets()
    }
    
    var currentFavorites: Favorites?
    
    let manager = RocketManager.shared
    
    var selectedRocket: Rocket? {
        didSet {
            manager.setCurrentFavorite(selectedRocket!)
        }
    }
    
    func getFavorites() {
        currentFavorites = manager.getFavoriteRockets()
    }
    
    func saveFavoriteRockets() {
        //TODO: Realm - save
        //manager.saveFavorites()
    }
    
    func isRocketInFavorites(_ rocket: Rocket) -> Bool  {
        return manager.isExistsInFavorites(rocketId: rocket.getId())
    }
    
    func updateFavoriteList(withStatusOf rocket: Rocket) {
        if isRocketInFavorites(rocket) {
            manager.removeFavoriteRocket(rocket)
        } else {
            manager.addFavoriteRocket(rocket)
        }
    }
    
}
