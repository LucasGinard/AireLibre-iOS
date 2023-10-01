//
//  HomeViewModel.swift
//  airelibre
//
//  Created by LucasG on 2022-04-12.
//

import Foundation
import Firebase

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
    
    func authForGetContributors(){
        Auth.auth().signInAnonymously { authResult, error in
            if let error = error {
                print("Error en la autenticación anónima: \(error.localizedDescription)")
                return
            }
            
            if let user = authResult?.user {
                print("Autenticación anónima exitosa. UID: \(user.uid)")
            }
        }
    }
}
