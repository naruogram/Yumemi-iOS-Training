//
//  InitialViewController.swift
//  Yumemi-iOS-Training
//
//  Created by 成尾 嘉貴 on 2022/06/23.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "viewController") as! ViewController
        self.present(viewController, animated: true, completion: nil)
    }
}
