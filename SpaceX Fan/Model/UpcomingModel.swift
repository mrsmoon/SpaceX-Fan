//
//  UpcomingModel.swift
//  SpaceX Fan
//
//  Created by Sera on 10/15/21.
//

import Foundation

struct UpcomingModel: Codable {
    private let id: String
    private let name: String
    private let details: String?
    private let links: Links
    private let date: String
    
    func getId() -> String {
        return id
    }
    
    func getName() -> String {
        return name
    }
    
    func getDetails() -> String {
        return details ?? ""
    }
    
    func getLinks() -> [String] {
        var imageLinks = [String]()
        if let smallPatch = links.getPatch().getSmall() {
            imageLinks.append(smallPatch)
        }
        
        if let largePatch = links.getPatch().getLarge() {
            imageLinks.append(largePatch)
        }
        
        let smallFlickr = links.getFlickr().getSmall()
        let originalFlickr = links.getFlickr().getOriginal()
        
        if  !smallFlickr.isEmpty {
            smallFlickr.forEach { imageLinks.append($0) }
        }
        
        if  !originalFlickr.isEmpty {
            originalFlickr.forEach { imageLinks.append($0) }
        }
        
        return imageLinks
    }
    
    func getDate() -> RemainingTime {
        return date.toDate().datePhraseRelativeToToday()
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case details
        case links
        case date = "date_utc"
    }
}

struct Links: Codable {
    private let patch: Patch
    private let flickr: Flickr
    
    func getPatch() -> Patch {
        return patch
    }
    
    func getFlickr() -> Flickr {
        return flickr
    }
}

struct Patch: Codable {
    private let small: String?
    private let large: String?
    
    func getSmall() -> String? {
        return small
    }
    
    func getLarge() -> String? {
        return large
    }
}

struct Flickr: Codable {
    private let small: [String]
    private let original: [String]
    
    func getSmall() -> [String] {
        return small
    }
    
    func getOriginal() -> [String] {
        return original
    }
}


