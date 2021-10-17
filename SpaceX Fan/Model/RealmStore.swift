//
//  RealmStore.swift
//  SpaceX Fan
//
//  Created by Sera on 10/17/21.
//

import Foundation
import RealmSwift

class RealmStore {
    static let shared = RealmStore()
    
    func saveFavoriteRocket(_ rocket: Rocket) {
        let realm = try! Realm()
        let newRocket = RocketData()
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
    
    func addFavoriteRocket(_ rocket: RocketData) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(rocket)
        }
    }

    func removeFavoriteRocket(_ rocket: RocketData) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(rocket)
        }
    }
    
    func loadFavorites() -> Favorites {
        
        let realm = try! Realm()
        
        return realm.objects(RocketData.self)
    }
}
