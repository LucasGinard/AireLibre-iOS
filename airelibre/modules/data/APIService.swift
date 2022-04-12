//
//  APIService.swift
//  airelibre
//
//  Created by LucasG on 2022-04-12.
//

import Foundation

class APIService :NSObject {
    
    private let sourcesURL = URL(string: "https://rald-dev.greenbeep.com/api/v1/aqi")!
    
    func apiToGetSensorData(completion : @escaping ([SensorResponse]) -> ()){
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let sensorpData = try! jsonDecoder.decode([SensorResponse].self, from: data)
                    completion(sensorpData)
            }
        }.resume()
    }
}
