//
//  HomeViewModel.swift
//  airelibre
//
//  Created by LucasG on 2022-04-12.
//

import Foundation

class HomeViewModel: NSObject {
    
    private var apiService : APIService!
    private(set) var sensor : [SensorResponse]! {
        didSet {
            self.bindHomeViewModelToController()
        }
    }
    
    var bindHomeViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
        callFuncToGetEmpData()
    }
    
    func callFuncToGetEmpData() {
        self.apiService.apiToGetSensorData { (sensor) in
            self.sensor = sensor
        }
    }
}
