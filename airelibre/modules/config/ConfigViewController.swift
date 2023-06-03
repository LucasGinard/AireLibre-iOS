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
    @IBOutlet weak var tvVersion: UILabel!
    @IBOutlet weak var stackThemesMaps: UIStackView!

    private let manager = CLLocationManager()
    private var viewModel:ConfigViewModel = ConfigViewModel()

    let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.showsHorizontalScrollIndicator = false
            return cv
        }()
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        configureUI()
        themeApp()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CircularItemCell.self, forCellWithReuseIdentifier: "CircularItemCell")
        stackThemesMaps.addArrangedSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        collectionView.reloadData()
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
        tvVersion.text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
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

extension ConfigViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Actualización del índice seleccionado y recarga de datos del collectionView
        selectedIndex = indexPath.row
        self.viewModel.setSaveThemeSelected(position: selectedIndex)
        collectionView.reloadData()
    }
}

extension ConfigViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getMapThemes().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CircularItemCell", for: indexPath) as! CircularItemCell
        let isSelected = indexPath.row == selectedIndex
        cell.configure(with: viewModel.getMapThemes()[indexPath.row], isSelected: isSelected)
        return cell
    }
}

extension ConfigViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 65, height: 95)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
