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
typealias Favorites = Results<RocketData>

protocol RocketProtocol {
    func getAllRockets(completionHandler: @escaping RocketsCallBack)
    func getAllUpcomingLaunches(completionHandler: @escaping UpcomingCallBack)
    func getFavoriteRockets() -> Favorites
}

class RocketManager: RocketProtocol {
    static let shared = RocketManager()
    
    private var latestRockets: Rockets?
    private var currentRocket: Rocket?
    private var currentFavorite: RocketData?
    private var currentUpcomingLaunch: UpcomingModel?
    private var favoriteRockets: Favorites {
        realmStore.loadFavorites()
    }
    
    var realmStore = RealmStore.shared
    
    //MARK: - All Rockets
    
    func getRockets() -> Rockets? {
        return latestRockets
    }
    
    func getCurrentRocket() -> Rocket? {
        return currentRocket
    }
    
    func setCurrentRocket(_ rocket: Rocket) {
        currentRocket = rocket
    }
    
    func setCurrentFavorite(_ rocket: RocketData) {
        currentFavorite = rocket
    }
    
    func getCurrentUpcomingLaunch() -> UpcomingModel? {
        return currentUpcomingLaunch
    }
    
    func setCurrentUpcomingLaunch(_ upcoming: UpcomingModel) {
        currentUpcomingLaunch = upcoming
    }
    
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
                print("Rockets are fecthed: \(rockets)")
                
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
                print("Upcomings are fecthed: \(upcomings)")
                
                completionHandler(upcomings, nil)
            } catch {
                print("Error parsing rockets: \(error)")
                completionHandler(nil, .parseError)
            }
        }
        
        dataTask.resume()
    }
    
    //MARK: - Favorites
    
    func getFavoriteRockets() -> Favorites {
        return favoriteRockets
    }
    
    func addFavoriteRocket(_ rocket: Rocket) {
        realmStore.saveFavoriteRocket(rocket)
    }
    
    func removeFavoriteRocket(_ rocket: Rocket) {
        let result = favoriteRockets.filter("id CONTAINS %@", rocket.getId())
        realmStore.removeFavoriteRocket(result.elements.first!)
    }
    
    func isExistsInFavorites(rocketId: String) -> Bool {
        return favoriteRockets.contains { $0.id == rocketId }
    }
    
}

enum APIError: Error {
    case responseError
    case parseError
}
