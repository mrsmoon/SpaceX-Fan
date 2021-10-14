//
//  RocketsViewController.swift
//  SpaceX Fan
//
//  Created by Sera on 10/14/21.
//

import UIKit

class RocketsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "FavoritesVC")
        
        navigationController?.pushViewController(vc, animated: true)
        
        // Do any additional setup after loading the view.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
