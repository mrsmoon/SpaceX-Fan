//
//  RocketData.swift
//  SpaceX Fan
//
//  Created by Sera on 10/17/21.
//

import Foundation
import RealmSwift

@objcMembers class RocketData: Object {
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var heightMeter: Double = 0.0
    dynamic var heightFeet: Double = 0.0
    dynamic var diameterMeter: Double = 0.0
    dynamic var diameterFeet: Double = 0.0
    dynamic var massKg: Double = 0.0
    dynamic var massLb: Double = 0.0
    let payload = List<PayLoad>()
    let images = List<String>()
    dynamic var rocketDescription: String = ""
    dynamic var isFavorite: Bool = false
    
    func getId() -> String {
        return id
    }

    func getName() -> String {
        return name
    }
    
    func getHeight() -> String {
        return heightMeter.toString() + " m / " + heightFeet.toString() + " ft"
    }

    func getDiameter() -> String {
        return diameterMeter.toString() + " m / " + diameterFeet.toString() + " ft"
    }

    func getMass() -> String{
        return massKg.toString() + " kg / " + massLb.toString() + " lb"
    }

    func getPayload() -> List<PayLoad> {
        return payload
    }
    
    func getImages() -> List<String> {
        return images
    }

    func getDescription() -> String {
        return rocketDescription
    }
}

@objcMembers class PayLoad: Object {
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var kg: Double = 0.0
    dynamic var lb: Double = 0.0
    var parentRocket = LinkingObjects(fromType: RocketData.self, property: "payload")
    
    func getId() -> String {
        return id
    }

    func getName() -> String {
        return name
    }

    func getPayloadKgLb() -> String {
        return kg.toString() + " kg / " + lb.toString() + " lb"
    }
}


