//
//  APIService.swift
//  airelibre
//
//  Created by LucasG on 2022-04-12.
//

import Foundation

class APIService:NSObject {
    
    func getDateURL() -> String{
        let date = Date()
        let dateString = Date().addingTimeInterval(-(60 * 60))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        return dateFormatter.string(from: dateString)
    }
    
    func apiToGetSensorData(completion : @escaping ([SensorResponse]) -> ()){
        var components = URLComponents(string: "https://rald-dev.greenbeep.com/api/v1/aqi")!
        let parameters = ["start": getDateURL()]
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: components.url!)
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let sensorpData = try! jsonDecoder.decode([SensorResponse].self, from: data)
                    completion(sensorpData ?? [])
            }
        }.resume()
    }
}

extension Date{
    func withAddedHours(hours: Double) -> Date {
             withAddedMinutes(minutes: hours * 60)
        }
    func withAddedMinutes(minutes: Double) -> Date {
             addingTimeInterval(minutes * 60)
        }
}
