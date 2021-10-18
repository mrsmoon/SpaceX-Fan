//
//  UpcomingViewModel.swift
//  SpaceX Fan
//
//  Created by Sera on 10/16/21.
//

import Foundation

protocol UpcomingViewModelDelegate {
    func upcomingsFetched()
}

class UpcomingViewModel {
    
    static let shared = UpcomingViewModel()
    
    func subscribe() {
        if upcomings.isEmpty {
            fetchUpcomings()
        }
    }
    
    let manager = RocketManager.shared
    var delegate: UpcomingViewModelDelegate?
    var upcomings = UpcomingLaunches()
    
    var selectedUpcoming: UpcomingModel? {
        didSet {
            manager.setCurrentUpcomingLaunch(selectedUpcoming!)
        }
    }
    
    func fetchUpcomings() {
        manager.getAllUpcomingLaunches(completionHandler: { (upcomings, error) in
            if let upcomings = upcomings {
                self.upcomings = upcomings
                self.delegate?.upcomingsFetched()
            }
        })
    }

}
