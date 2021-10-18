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
    
    static let shared = RocketViewModel()
    
    func subscribe() {
        if rockets == nil {
            fetchRockets()
            getRockets()
        } else {
            rockets = manager.getRockets()
            self.delegate?.rocketsFetched()
        }
    }
    
    func unsubscribe() {
    }
    
    let manager = RocketManager.shared
    var rockets: SpaceXRockets?
    
    var delegate: RocketViewModelDelegate?
    
    var selectedRocket: RocketData? {
        didSet {
            manager.setCurrentRocket(selectedRocket!)
        }
    }
    
    func getRockets() {
        rockets = manager.getRockets()
        print("ROCKETS: \(rockets)")
    }
    
    func fetchRockets() {
        manager.getAllRockets { (rockets, error) in
            if let rockets = rockets {
                self.delegate?.rocketsFetched()
            } else {
                self.delegate?.rocketFetchingDidFail()
            }
        }
    }
    
    func isRocketInFavorites(_ rocket: RocketData) -> Bool  {
        return manager.isExistsInFavorites(rocketId: rocket.getId())
    }
    
    func updateFavoriteList(withStatusOf rocket: RocketData) {
        manager.updateFavoriteStatus(rocket)
    }
}
