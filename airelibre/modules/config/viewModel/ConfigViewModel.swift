//
//  ConfigViewModel.swift
//  airelibre
//
//  Created by MacBook Pro on 2023-06-03.
//

import Foundation

class ConfigViewModel: NSObject {
    
    func getMapThemes()-> [CircularItemModel]{
        let defaultTheme = ThemesMap.predMap.getMapTheme(.predMap)
        let uberTheme = ThemesMap.predMap.getMapTheme(.uber)
        let retroTheme = ThemesMap.predMap.getMapTheme(.retro)
        let blueLightTheme = ThemesMap.predMap.getMapTheme(.bluelLight)
        let blueTheme = ThemesMap.predMap.getMapTheme(.blue)
        let cyberTheme = ThemesMap.predMap.getMapTheme(.cyber)
        let falloutTheme = ThemesMap.predMap.getMapTheme(.fallout)
        let gtaTheme = ThemesMap.predMap.getMapTheme(.gta)
        return  [
            CircularItemModel(image: defaultTheme.imagePreview, title: defaultTheme.name,enumTheme: ThemesMap.predMap),
            CircularItemModel(image: uberTheme.imagePreview, title: uberTheme.name,enumTheme: ThemesMap.uber),
            CircularItemModel(image: retroTheme.imagePreview, title: retroTheme.name,enumTheme: ThemesMap.retro),
            CircularItemModel(image: blueLightTheme.imagePreview, title: blueLightTheme.name,enumTheme: ThemesMap.bluelLight),
            CircularItemModel(image: blueTheme.imagePreview, title: blueTheme.name,enumTheme: ThemesMap.blue),
            CircularItemModel(image: cyberTheme.imagePreview, title: cyberTheme.name,enumTheme: ThemesMap.cyber),
            CircularItemModel(image: falloutTheme.imagePreview, title: falloutTheme.name,enumTheme: ThemesMap.fallout),
            CircularItemModel(image: gtaTheme.imagePreview, title: gtaTheme.name,enumTheme: ThemesMap.gta)
        ]
    }
    
    func setSaveThemeSelected(position:Int){
        let selectedTheme = getMapThemes()[position].enumTheme
        UserDefaults.standard.set(selectedTheme.rawValue, forKey: "selectedTheme")
    }
    
}
