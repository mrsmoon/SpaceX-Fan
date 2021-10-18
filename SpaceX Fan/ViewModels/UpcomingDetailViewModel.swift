//
//  UpcomingDetailViewModel.swift
//  SpaceX Fan
//
//  Created by Sera on 10/18/21.
//

import Foundation

class UpcomingDetailViewModel {
    static let shared = UpcomingDetailViewModel()
    
    func subscribe() {
        currentUpcoming = manager.getCurrentUpcomingLaunch()
    }
    
    let manager = RocketManager.shared
    
    var currentUpcoming: UpcomingModel?
}
