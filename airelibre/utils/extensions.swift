//
//  extensions.swift
//  airelibre
//
//  Created by LucasG on 2022-05-05.
//

import Foundation
import UIKit


extension UIView {
    
    @IBInspectable var cornerRadiusTop: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }

}

extension UIViewController{
    func alertDialog(title:String,subTitle:String,buttonAceptText:String,buttonCancelText:String="Cancelar",acept: @escaping () -> Void,cancel: @escaping () -> Void){
        let alertController = UIAlertController (title: title, message: subTitle, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: buttonAceptText, style: .default, handler: { (action) in
            acept()
        }))
        let cancelAction = UIAlertAction(title: buttonCancelText, style: .default, handler: { (action) in
            cancel()
        })
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func themeApp(){
        let theme = UserDefaults.standard.string(forKey: "isDarkMode")
        if(theme == nil){
            if(self.traitCollection.userInterfaceStyle == .dark){
                self.overrideUserInterfaceStyle = .dark
            }else{
                self.overrideUserInterfaceStyle = .light
            }
        }else{
            if(theme == "Dark"){
                self.overrideUserInterfaceStyle = .dark
            }else{
                self.overrideUserInterfaceStyle = .light
            }
        }
    }
    
    func isDarkTheme() -> Bool{
        let theme = UserDefaults.standard.string(forKey: "isDarkMode")
        if(theme == nil){
            if(self.traitCollection.userInterfaceStyle == .dark){
                return true
            }else{
                return false
            }
        }else{
            if(theme == "Dark"){
                return true
            }else{
                return false
            }
        }
    }
}

extension UIViewController{
    
    func emojiScale(index:Int)->String{
        switch(index){
            case 0...50: return "🟢👍"
            case 51...100: return "🟡😐"
            case 101...150: return "🟠⚠"
            case 151...200: return "🔴⚠"
            case 201...300:  return "🟣☣️"
            default: return "🟤☠️"
        }
    }
    
    func markerImage(index:Int)-> UIImage?{
        switch(index){
            case 0...50: return UIImage(named:"MarkerGreen")
            case 51...100: return UIImage(named:"MarkerYellow")
            case 101...150: return UIImage(named:"MarkerOrange")
            case 151...200: return UIImage(named:"MarkerRed")
            case 201...300:  return UIImage(named:"MarkerPurple")
            default: return UIImage(named:"MarkerDanger")
        }
        return nil
    }
    
    func qualityScaleText(index:Int)->String{
        switch(index){
            case 0...50: return "Libre"
            case 51...100: return "Maso"
            case 101...150: return "No tan bien"
            case 151...200: return "Insalubre"
            case 201...300:  return "Muy insalubre"
            default: return "Peligroso"
        }
    }
}

extension UIColor {
  
  convenience init(_ hex: String, alpha: CGFloat = 1.0) {
    var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if cString.hasPrefix("#") { cString.removeFirst() }
    
    if cString.count != 6 {
      self.init("ff0000") // return red color for wrong hex input
      return
    }
    
    var rgbValue: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
              alpha: alpha)
  }

}
