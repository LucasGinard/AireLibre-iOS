//
//  HomeViewController.swift
//  airelibre
//
//  Created by LucasG on 2022-04-12.
//

import UIKit

class HomeViewController: UIViewController {

    private var homeViewModel:HomeViewModel!
    private var sensorList:[SensorResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callService()
    }


    func callService(){
        self.homeViewModel = HomeViewModel()
        self.homeViewModel.bindHomeViewModelToController = {
            self.homeViewModel.sensor.forEach{
                sensor in self.sensorList.append(sensor)
            }
        }
    }
}
