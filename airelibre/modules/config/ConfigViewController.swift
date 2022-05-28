//
//  ViewController.swift
//  airelibre
//
//  Created by LucasG on 2022-04-09.
//

import UIKit
import CoreLocation

class ConfigViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var swDarkMode: UISwitch!
    @IBOutlet weak var swLocation: UISwitch!
    
    private let manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        themeApp()
    }
    
    func configureUI(){
        if #available(iOS 13.0, *){
            if(self.traitCollection.userInterfaceStyle == .dark){
                swDarkMode.isOn = true
            }else{
                swDarkMode.isOn = false
            }
        } else {
            swDarkMode.isHidden = true
        }
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
                case .notDetermined, .restricted, .denied:
                    swLocation.isOn = false
                case .authorizedAlways, .authorizedWhenInUse:
                    swLocation.isOn = true
                @unknown default:
                    break
            }
        } else {
            swLocation.isOn = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            swLocation.isOn = true
        }
    }
    
    @IBAction func switchDarkMode(_ sender: Any) {
        if(UserDefaults.standard.bool(forKey: "isThemeCustom") as? Bool ?? false){
            if swDarkMode.isOn{
                overrideUserInterfaceStyle = .dark
                UserDefaults.standard.set("Dark", forKey: "isDarkMode")
            }else{
                overrideUserInterfaceStyle = .light
                UserDefaults.standard.set("Light", forKey: "isDarkMode")
            }
        }else{
            self.alertDialog(title: "Atención", subTitle: "Si cambias el modo ya no se tendra en cuenta el modo del telefono", buttonAceptText: "Acepto",
                             buttonCancelText: "Cancelar") {
                UserDefaults.standard.set(true, forKey: "isThemeCustom")
                if self.swDarkMode.isOn{
                    self.overrideUserInterfaceStyle = .dark
                    UserDefaults.standard.set("Dark", forKey: "isDarkMode")
                }else{
                    self.overrideUserInterfaceStyle = .light
                    UserDefaults.standard.set("Light", forKey: "isDarkMode")
                }
            } cancel: {
                if(self.swDarkMode.isOn){
                    self.swDarkMode.isOn = false
                }else{
                    self.swDarkMode.isOn = true
                }
            }

        }
        
    }
    
    @IBAction func switchLocation(_ sender: Any) {
        if swLocation.isOn{
            self.alertDialog(title: "Active su ubicacion", subTitle: "No podemos activar su ubicación por seguridad activela usted en configuración",
                             buttonAceptText: "Configuración", buttonCancelText: "Cancelar", acept: {
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                }
            }, cancel: {
                self.swLocation.isOn = false
            })
        }
    }
    
}
