//
//  ThemesMap.swift
//  airelibre
//
//  Created by MacBook Pro on 2023-06-02.
//

import Foundation

enum ThemesMap {
    case predMap
    case uber
    
    func getMapTheme(_ theme:ThemesMap)-> MapModel{
        switch(theme){
        case .predMap:
            return MapModel(name: "Pred", map: Bundle.main.url(forResource: "mapstyle_night", withExtension: "json") ?? URL(fileURLWithPath: ""),textColor: .black)
        case .uber:
            return MapModel(name: "Uber", map: Bundle.main.url(forResource: "mapstyle_uber", withExtension: "json") ?? URL(fileURLWithPath: ""),textColor: .black)
        }
    }
}
