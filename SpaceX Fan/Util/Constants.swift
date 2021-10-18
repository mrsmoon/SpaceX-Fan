//
//  Constants.swift
//  SpaceX Fan
//
//  Created by Sera on 10/14/21.
//

import Foundation

class Constants {
    static let rocketSegueIdentifier = "RocketSegue"
    static let favoriteSegueIdentifier = "FavoriteSegue"
    static let upcomingSegueIdentifier = "UpcomingSegue"
    
    static let rocketCellIdentifier = "RocketCell"
    static let rocketDetailCellIdentifier = "RocketDetailCell"
    static let upcomingCellIdentifier = "UpcomingCell"
    static let upcomingDetailCellIdentifier = "UpcomingDetailCell"
    static let imageCellIdentifier = "ImageCell"
    
    static let favoritesStoryboardId = "FavoritesVC"
    static let rocketsStoryboardId = "RocketsVC"
    static let upcomingStoryboardId = "UpcomingVC"
    static let rocketDetailStoryboardId = "RocketDetailVC"
    
    static let rocketsTitle = "SpaceX Rockets"
    static let favoritesTitle = "Favorite Rockets"
    static let upcomingTitle = "Upcoming Launchers"
    
    static let nasalizationFont = "NasalizationRg-Regular"
    static let muliBold = "Muli-Bold"
    static let muliRegular = "Muli"
    
    static let rocketsURL = "https://api.spacexdata.com/v4/rockets"
    static let upcomingURL = "https://api.spacexdata.com/v5/launches/upcoming"
}
