//
//  FavoritesViewModel.swift
//  SpaceX Fan
//
//  Created by Sera on 10/15/21.
//

import Foundation

class FavoritesViewModel {
    
    static let shared = FavoritesViewModel()
    
    func subscribe() {
        getFavorites()
    }
    
    func unsubscribe() {
    }
    
    var currentFavorites: Favorites?
    
    let manager = RocketManager.shared
    
    var selectedRocket: RocketData? {
        didSet {
            manager.setCurrentFavorite(selectedRocket!)
        }
    }
    
    func getFavorites() {
        currentFavorites = manager.getFavoriteRockets()
    }
    
    func isRocketInFavorites(_ rocket: RocketData) -> Bool  {
        return manager.isExistsInFavorites(rocketId: rocket.getId())
    }
    
    func updateFavoriteList(withStatusOf rocket: RocketData) {
        if isRocketInFavorites(rocket) {
            manager.realmStore.removeFavoriteRocket(rocket)
        } else {
            manager.realmStore.addFavoriteRocket(rocket)
        }
    }
    
}
