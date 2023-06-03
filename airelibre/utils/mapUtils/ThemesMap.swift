//
//  ThemesMap.swift
//  airelibre
//
//  Created by MacBook Pro on 2023-06-02.
//

import Foundation
import UIKit

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
            return MapModel(name: "Pred", map: (UserDefaults.standard.string(forKey: "isDarkMode")  == "Dark") ? Bundle.main.url(forResource: "mapstyle_night", withExtension: "json")! : nil,textColor: (UserDefaults.standard.string(forKey: "isDarkMode") != nil) ? .white : .black,imagePreview: UIImage(named: "ThemeMapPred")! )
        case .uber:
            return MapModel(name: "Uber", map: Bundle.main.url(forResource: "mapstyle_uber", withExtension: "json") ?? URL(fileURLWithPath: ""),textColor: .black,imagePreview: UIImage(named: "ThemeMapUber")!)
        case .retro:
            return MapModel(name: "Retro", map: Bundle.main.url(forResource: "mapstyle_retro", withExtension: "json") ?? URL(fileURLWithPath: ""),textColor: .black,imagePreview:UIImage(named: "ThemeMapRetro")!)
        case .bluelLight:
            return MapModel(name: "Celeste", map: Bundle.main.url(forResource: "mapstyle_light_blue", withExtension: "json") ?? URL(fileURLWithPath: ""),textColor: .black,imagePreview:UIImage(named: "ThemeMapBlueLight")!)
        case .blue:
            return MapModel(name: "Azul", map: Bundle.main.url(forResource: "mapstyle_blue", withExtension: "json") ?? URL(fileURLWithPath: ""),textColor: .white,imagePreview:UIImage(named: "ThemeMapBlue")!)
        case .cyber:
            return MapModel(name: "Futurista", map: Bundle.main.url(forResource: "mapstyle_cyber", withExtension: "json") ?? URL(fileURLWithPath: ""),textColor: .white,imagePreview:UIImage(named: "ThemeMapCyber")!)
        case .fallout:
            return MapModel(name: "Fallout", map: Bundle.main.url(forResource: "mapstyle_fallout", withExtension: "json") ?? URL(fileURLWithPath: ""),textColor: .white,imagePreview:UIImage(named: "ThemeMapFallout")!)
        case .gta:
            return MapModel(name: "GTA", map: Bundle.main.url(forResource: "mapstyle_gta", withExtension: "json") ?? URL(fileURLWithPath: ""),textColor: .white,imagePreview:UIImage(named: "ThemeMapGTA")!)
        }
    }
}
