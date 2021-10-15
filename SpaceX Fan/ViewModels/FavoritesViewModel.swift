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
    
    var currentFavorites = Rockets()
    
    let manager = RocketManager.shared
    
    func getFavorites() {
        currentFavorites = Array(manager.getFavoriteRockets())
    }
    
    func saveFavoriteRockets() {
        //TODO: Realm - save
        manager.saveFavorites()
    }
    
    func isRocketInFavorites(_ rocket: RocketModel) -> Bool  {
        if currentFavorites.contains(rocket) {
            return true
        }
        
        return false
    }
    
    func updateFavoriteList(withStatusOf rocket: RocketModel) {
        if isRocketInFavorites(rocket) {
            manager.removeFavoriteRocket(rocket)
        } else {
            manager.addFavoriteRocket(rocket)
        }
    }
    
}
