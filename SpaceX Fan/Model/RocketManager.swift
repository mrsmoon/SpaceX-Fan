//
//  RocketManager.swift
//  SpaceX Fan
//
//  Created by Sera on 10/15/21.
//

import Foundation
import RealmSwift

typealias RocketInfo = RocketModel
typealias Rockets = [RocketModel]
typealias UpcomingLaunches = [UpcomingModel]
typealias RocketsCallBack = (Rockets?, APIError?) -> Void
typealias UpcomingCallBack = (UpcomingLaunches?, APIError?) -> Void
typealias Favorites = Results<Rocket>

protocol RocketProtocol {
    func getAllRockets(completionHandler: @escaping RocketsCallBack)
    func getAllUpcomingLaunches(completionHandler: @escaping UpcomingCallBack)
    func getFavoriteRockets() -> Favorites
}

class RocketManager: RocketProtocol {
    static let shared = RocketManager()
    
    private var latestRockets: Rockets?
    private var currentRocket: RocketInfo?
    private var currentFavorite: Rocket?
    private var currentUpcomingLaunch: UpcomingModel?
    
    private var favoriteRockets: Favorites {
        loadFavorites()
    }
    
    //MARK: - All Rockets
    
    func getRockets() -> Rockets? {
        return latestRockets
    }
    
    func getCurrentRocket() -> RocketInfo? {
        return currentRocket
    }
    
    func setCurrentRocket(_ rocket: RocketInfo) {
        currentRocket = rocket
    }
    
    func setCurrentFavorite(_ rocket: Rocket) {
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
                self.latestRockets = rockets
                print("Rockets are fetched: \(rockets)")
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
    
    func addFavoriteRocket(_ rocket: RocketInfo) {
        saveFavoriteRocket(rocket)
    }
    
    func removeFavoriteRocket(_ rocket: RocketInfo) {
        let result = favoriteRockets.filter("id CONTAINS %@", rocket.getId())
        removeFavoriteRocket(result.elements.first!)
    }
    
    func isExistsInFavorites(rocketId: String) -> Bool {
        return favoriteRockets.contains { $0.id == rocketId }
    }
    
    //MARK: - Realm
    
    func saveFavoriteRocket(_ rocket: RocketInfo) {
        let realm = try! Realm()
        let newRocket = Rocket()
        newRocket.id = rocket.getId()
        newRocket.name = rocket.getName()
        newRocket.heightMeter = rocket.getHeight().getMeters()
        newRocket.heightFeet = rocket.getHeight().getFeet()
        newRocket.diameterMeter = rocket.getDiameter().getMeters()
        newRocket.diameterFeet = rocket.getDiameter().getFeet()
        newRocket.massLb = rocket.getMass().getLb()
        newRocket.massKg = rocket.getMass().getKg()
        newRocket.rocketDescription = rocket.getDescription()
            
        try! realm.write {
            realm.add(newRocket)
            rocket.getPayload().forEach { (payload) in
                let newPayload = PayLoad()
                newPayload.id = payload.getId()
                newPayload.name = payload.getName()
                newPayload.kg = payload.getKg()
                newPayload.lb = payload.getLb()
                newRocket.payload.append(newPayload)
            }
            rocket.getImages().forEach { (image) in
                newRocket.images.append(image)
            }
        }
    }
    
    func addFavoriteRocket(_ rocket: Rocket) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(rocket)
        }
    }

    func removeFavoriteRocket(_ rocket: Rocket) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(rocket)
        }
    }
    
    func loadFavorites() -> Results<Rocket> {
        
        let realm = try! Realm()
        
        return realm.objects(Rocket.self)
    }
    
}

enum APIError: Error {
    case responseError
    case parseError
}
