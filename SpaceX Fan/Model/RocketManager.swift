//
//  RocketManager.swift
//  SpaceX Fan
//
//  Created by Sera on 10/15/21.
//

import Foundation

typealias Rockets = [RocketModel]

protocol RocketProtocol {
    func getAllRockets(completionHandler: @escaping (Rockets?, Error?) -> Void)
    func getAllUpcomingLaunches(completionHandler: @escaping (Rockets?, Error?) -> Void)
}

class RocketManager: RocketProtocol {
    static let shared = RocketManager()
    
    private var latestRockets: Rockets?
    
    func getRockets() -> Rockets? {
        return latestRockets
    }
    
    func getAllRockets(completionHandler: @escaping (Rockets?, Error?) -> Void) {
        
    }
    
    func getAllUpcomingLaunches(completionHandler: @escaping (Rockets?, Error?) -> Void) {
        
    }
    
}
