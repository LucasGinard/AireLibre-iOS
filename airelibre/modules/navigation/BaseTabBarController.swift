//
//  BaseTabBarController.swift
//  airelibre
//
//  Created by LucasG on 2022-04-10.
//

import UIKit

class BaseTabBarController: UITabBarController {

    @IBInspectable var defaultIndex: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = defaultIndex
    }


}
