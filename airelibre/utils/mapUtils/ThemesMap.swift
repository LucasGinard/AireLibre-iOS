//
//  ThemesMap.swift
//  airelibre
//
//  Created by MacBook Pro on 2023-06-02.
//

import Foundation

enum ThemesMap:String {
    case predMap
    case uber
    case retro
    case bluelLight
    case blue
    case cyber
    case fallout
    case gta
    
    func getMapTheme(_ theme:ThemesMap)-> MapModel{
        switch(theme){
        case .predMap:
            return MapModel(name: "Pred", map: Bundle.main.url(forResource: "mapstyle_night", withExtension: "json") ?? URL(fileURLWithPath: ""),textColor: (UserDefaults.standard.string(forKey: "isDarkMode") != nil) ? .white : .black )
        case .uber:
            return MapModel(name: "Uber", map: Bundle.main.url(forResource: "mapstyle_uber", withExtension: "json") ?? URL(fileURLWithPath: ""),textColor: .black)
        case .retro:
            return MapModel(name: "Retro", map: Bundle.main.url(forResource: "mapstyle_retro", withExtension: "json") ?? URL(fileURLWithPath: ""),textColor: .black)
        case .bluelLight:
            return MapModel(name: "Celeste", map: Bundle.main.url(forResource: "mapstyle_light_blue", withExtension: "json") ?? URL(fileURLWithPath: ""),textColor: .black)
        case .blue:
            return MapModel(name: "Azul", map: Bundle.main.url(forResource: "mapstyle_blue", withExtension: "json") ?? URL(fileURLWithPath: ""),textColor: .white)
        case .cyber:
            return MapModel(name: "Futurista", map: Bundle.main.url(forResource: "mapstyle_cyber", withExtension: "json") ?? URL(fileURLWithPath: ""),textColor: .white)
        case .fallout:
            return MapModel(name: "Fallout", map: Bundle.main.url(forResource: "mapstyle_fallout", withExtension: "json") ?? URL(fileURLWithPath: ""),textColor: .white)
        case .gta:
            return MapModel(name: "GTA", map: Bundle.main.url(forResource: "mapstyle_gta", withExtension: "json") ?? URL(fileURLWithPath: ""),textColor: .white)
        }
    }
}
