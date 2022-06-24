//
//  InitialViewController.swift
//  Yumemi-iOS-Training
//
//  Created by 成尾 嘉貴 on 2022/06/23.
//

import UIKit

class InitialViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "weatherViewController") else {
            return
        }
        present(viewController, animated: true, completion: nil)
    }
}
