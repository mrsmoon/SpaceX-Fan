//
//  Constants.swift
//  SpaceX Fan
//
//  Created by Sera on 10/14/21.
//

import Foundation

class Constants {
    
    //MARK: - Segue Identifiers
    
    static let rocketSegueIdentifier = "RocketSegue"
    static let favoriteSegueIdentifier = "FavoriteSegue"
    static let upcomingSegueIdentifier = "UpcomingSegue"
    
    //MARK: - Cell Identifiers
    
    static let rocketCellIdentifier = "RocketCell"
    static let rocketDetailCellIdentifier = "RocketDetailCell"
    static let upcomingCellIdentifier = "UpcomingCell"
    static let upcomingDetailCellIdentifier = "UpcomingDetailCell"
    static let imageCellIdentifier = "ImageCell"
    
    //MARK: - Storyboard Identifiers
    
    static let favoritesStoryboardId = "FavoritesVC"
    static let rocketsStoryboardId = "RocketsVC"
    static let upcomingStoryboardId = "UpcomingVC"
    static let rocketDetailStoryboardId = "RocketDetailVC"
    
    static let mainStoryboard = "Main"
    
    //MARK: - Page Titles
    
    static let rocketsTitle = "SpaceX Rockets"
    static let favoritesTitle = "Favorite Rockets"
    static let upcomingTitle = "Upcoming Launchers"
    
    //MARK: - Fonts
    
    static let nasalizationFont = "NasalizationRg-Regular"
    static let muliBold = "Muli-Bold"
    static let muliRegular = "Muli"
    static let muliSemibold = "Muli-SemiBold"
    
    //MARK: - API URLs
    
    static let rocketsURL = "https://api.spacexdata.com/v4/rockets"
    static let upcomingURL = "https://api.spacexdata.com/v5/launches/upcoming"
    
    //MARK: - Error
    
    static let errorMessage = "We are having problem to display SpaceX rockets now. Please try again later."
    
    //MARK: - Firebase App Events
    
    static let logEvent1 = "favorite_tab_pressed"
    static let logEvent2 = "rocket_detail_displayed"
    static let logEvent3 = "explore_button_pressed"
    static let logEvent4 = "upcoming_detail_displayed"
    
}
