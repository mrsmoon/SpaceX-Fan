//
//  RocketDetailViewModel.swift
//  SpaceX Fan
//
//  Created by Sera on 10/17/21.
//

import Foundation

class RocketDetailViewModel {
    static let shared = RocketDetailViewModel()
    
    let manager = RocketManager.shared
    
    var currentRocket: RocketData? {
        manager.getCurrentFavorite()
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


