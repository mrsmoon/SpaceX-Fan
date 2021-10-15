//
//  RocketModel.swift
//  SpaceX Fan
//
//  Created by Sera on 10/15/21.
//

import Foundation

struct RocketModel: Codable {
    private let id: String
    private let name: String
    private let height: Height
    private let diameter: Diameter
    private let mass: Mass
    private let payload: [Payload]
    private let images: [String]
    private let description: String
    
    func getId() -> String {
        return id
    }
    
    func getName() -> String {
        return name
    }
    
    func getHeight() -> Height {
        return height
    }
    
    func getDiameter() -> Diameter {
        return diameter
    }
    
    func getMass() -> Mass {
        return mass
    }
    
    func getPayload() -> [Payload] {
        return payload
    }
    
    func getImages() -> [String] {
        return images
    }
    
    func getDescription() -> String {
        return description
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case height
        case diameter
        case mass
        case payload = "payload_weights"
        case images = "flickr_images"
        case description
    }
}

struct Height: Codable, Hashable {
    private let meters: Double
    private let feet: Double
    
    func getMeters() -> Double {
        return meters
    }
    
    func getFeet() -> Double {
        return feet
    }
}

struct Diameter: Codable, Hashable {
    private let meters: Double
    private let feet: Double
    
    func getMeters() -> Double {
        return meters
    }
    
    func getFeet() -> Double {
        return feet
    }
}

struct Mass: Codable, Hashable {
    private let kg: Double
    private let lb: Double
    
    func getKg() -> Double {
        return kg
    }
    
    func getLb() -> Double {
        return lb
    }
}

struct Payload: Codable, Hashable{
    private let id: String
    private let name: String
    private let kg: Double
    private let lb: Double
    
    func getId() -> String {
        return id
    }
    
    func getName() -> String {
        return name
    }
    
    func getKg() -> Double {
        return kg
    }
    
    func getLb() -> Double {
        return lb
    }
}

extension RocketModel: Hashable {
    static func == (lhs: RocketModel, rhs: RocketModel) -> Bool {
        return lhs.id == rhs.id
    }
}
