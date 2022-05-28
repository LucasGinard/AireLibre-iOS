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
}
