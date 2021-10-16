//
//  Double+Extension.swift
//  SpaceX Fan
//
//  Created by Sera on 10/16/21.
//

import Foundation

extension Double {
    func toString() -> String {
        return self == Double(Int(self)) ? "\(Int(self))" : String(format: "%.1f" , self)
    }
}
