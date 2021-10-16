//
//  RocketManager.swift
//  SpaceX Fan
//
//  Created by Sera on 10/15/21.
//

import Foundation

typealias Rocket = RocketModel
typealias Rockets = [RocketModel]
typealias UpcomingLaunches = [UpcomingModel]
typealias RocketsCallBack = (Rockets?, APIError?) -> Void
typealias UpcomingCallBack = (UpcomingLaunches?, APIError?) -> Void
typealias Favorites = Set<RocketModel>

protocol RocketProtocol {
    func getAllRockets(completionHandler: @escaping RocketsCallBack)
    func getAllUpcomingLaunches(completionHandler: @escaping UpcomingCallBack)
    func getFavoriteRockets() -> Favorites
}

class RocketManager: RocketProtocol {
    static let shared = RocketManager()
    
    private var latestRockets: Rockets?
    private var favoriteRockets = Favorites()
    private var currentRocket: Rocket?
    private var currentUpcomingLaunch: UpcomingModel?
    
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
    
    func addFavoriteRocket(_ rocket: RocketModel) {
        favoriteRockets.insert(rocket)
        print(favoriteRockets)
        print(favoriteRockets.count)
    }
    
    func removeFavoriteRocket(_ rocket: RocketModel) {
        favoriteRockets.remove(rocket)
    }
    
    //MARK: - Realm
    
    func loadFavorites() {
        
    }
    
    func saveFavorites() {
        
    }
    
}

enum APIError: Error {
    case responseError
    case parseError
}
