//
//  SensorResponse.swift
//  airelibre
//
//  Created by LucasG on 2022-04-12.
//

import Foundation

struct SensorResponse:Decodable {
    let sensor:String
    let source:String
    let description: String
    let longitude,latitude: Double
    let quality:Quality
}

struct Quality: Decodable {
    let category: String
    let index: Int
}
