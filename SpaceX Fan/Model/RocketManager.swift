//
//  RocketManager.swift
//  SpaceX Fan
//
//  Created by Sera on 10/15/21.
//

import Foundation
import RealmSwift

typealias Rocket = RocketModel
typealias Rockets = [RocketModel]
typealias UpcomingLaunches = [UpcomingModel]
typealias RocketsCallBack = (Rockets?, APIError?) -> Void
typealias UpcomingCallBack = (UpcomingLaunches?, APIError?) -> Void
typealias SpaceXRockets = Results<RocketData>

protocol RocketProtocol {
    func getAllRockets(completionHandler: @escaping RocketsCallBack)
    func getAllUpcomingLaunches(completionHandler: @escaping UpcomingCallBack)
    func getFavoriteRockets() -> SpaceXRockets
}

class RocketManager: RocketProtocol {
    static let shared = RocketManager()
    
    private var currentRocket: RocketData?
    private var currentUpcomingLaunch: UpcomingModel?
    
    var realmStore = RealmStore.shared
    
    func getRockets() -> SpaceXRockets? {
        realmStore.loadRockets()
    }
    
    func getCurrentRocket() -> RocketData? {
        return currentRocket
    }
    
    func setCurrentRocket(_ rocket: RocketData) {
        currentRocket = rocket
    }
    
    func getCurrentUpcomingLaunch() -> UpcomingModel? {
        return currentUpcomingLaunch
    }
    
    func setCurrentUpcomingLaunch(_ upcoming: UpcomingModel) {
        currentUpcomingLaunch = upcoming
    }
    
    //MARK: - API Calls
    
    func getAllRockets(completionHandler: @escaping RocketsCallBack) {
        guard let resourceURL = URL(string: Constants.rocketsURL) else { fatalError() }
        
        var urlRequest = URLRequest(url: resourceURL)
        urlRequest.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                print("Response error for getting rockets")
                completionHandler(nil, .responseError)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let rockets = try decoder.decode(Rockets.self, from: jsonData)
                print("Rockets are fecthed")
                self.realmStore.saveRockets(rockets)
                completionHandler(rockets, nil)
            } catch {
                print("Error parsing rockets: \(error)")
                completionHandler(nil, .parseError)
            }
        }
        
        dataTask.resume()
    }
    
    func getAllUpcomingLaunches(completionHandler: @escaping UpcomingCallBack) {
        guard let resourceURL = URL(string: Constants.upcomingURL) else { fatalError() }
        
        var urlRequest = URLRequest(url: resourceURL)
        urlRequest.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                print("Response error for getting upcomings")
                completionHandler(nil, .responseError)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let upcomings = try decoder.decode(UpcomingLaunches.self, from: jsonData)
                print("Upcomings are fetched")
                
                completionHandler(upcomings, nil)
            } catch {
                print("Error upcoming parsing: \(error)")
                completionHandler(nil, .parseError)
            }
        }
        
        dataTask.resume()
    }
    
    //MARK: - Favorites
    
    func getFavoriteRockets() -> SpaceXRockets {
        realmStore.loadFavorites()
    }
    
    
    func updateFavoriteStatus(_ rocket: RocketData) {
        realmStore.updateRocketStatus(rocket)
    }
    
    func isExistsInFavorites(rocketId: String) -> Bool {
        let favorites = getFavoriteRockets()
        return favorites.contains { $0.id == rocketId }
    }
    
}

enum APIError: Error {
    case responseError
    case parseError
}
