//
//  UIViewController+Extension.swift
//  SpaceX Fan
//
//  Created by Sera on 10/17/21.
//

import UIKit
import LocalAuthentication

extension UIViewController {
    func getFaceIDAuthorization() {
        let context = LAContext()
        var error: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authorize with touch id!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] (success, error) in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        let alert = UIAlertController(title: "Failed to Authenticate",
                                                      message: " Please try again.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                        self?.present(alert, animated: true, completion: nil)
                        return
                    }
                    
                    let story = UIStoryboard(name: "Main", bundle: nil)
                    let vc = story.instantiateViewController(withIdentifier: Constants.favoritesStoryboardId)
                            
                    self?.navigationController?.pushViewController(vc, animated: false)
                }
            }
        } else {
            let alert = UIAlertController(title: "Unavailable",
                                          message: " You can't use this feature.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
