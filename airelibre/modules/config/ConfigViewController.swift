//
//  ViewController.swift
//  airelibre
//
//  Created by LucasG on 2022-04-09.
//

import UIKit

class ConfigViewController: UIViewController {

    @IBOutlet weak var swDarkMode: UISwitch!
    @IBOutlet weak var swLocation: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func switchDarkMode(_ sender: Any) {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .dark
        }
    }
    
}

