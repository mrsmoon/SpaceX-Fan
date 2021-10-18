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
    
    var currentFavorites: SpaceXRockets?
    
    let manager = RocketManager.shared
    
    var selectedRocket: RocketData? {
        didSet {
            manager.setCurrentRocket(selectedRocket!)
        }
    }
    
    func getFavorites() {
        currentFavorites = manager.getFavoriteRockets()
    }
    
    func isRocketInFavorites(_ rocket: RocketData) -> Bool  {
        return manager.isExistsInFavorites(rocketId: rocket.getId())
    }
    
    func updateFavoriteList(withStatusOf rocket: RocketData) {
        manager.updateFavoriteStatus(rocket)
    }
    
}
