//
//  HomeViewController.swift
//  airelibre
//
//  Created by LucasG on 2022-04-12.
//

import UIKit
import GoogleMaps

class HomeViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var viewMap: UIView!
    private var homeViewModel:HomeViewModel!
    private var sensorList:[SensorResponse] = []
    
    private let manager = CLLocationManager()
    private var mapView:GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey("")
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        createMap()
        callService()
    }

    func createMap(){
        let camera = GMSCameraPosition.camera(withLatitude: -25.250, longitude: -57.536, zoom: 10)
        mapView = GMSMapView.map(withFrame: self.viewMap.frame, camera: camera)
        mapView.isMyLocationEnabled = true
        self.viewMap.addSubview(mapView)
    }
    
    func callService(){
        self.homeViewModel = HomeViewModel()
        self.homeViewModel.bindHomeViewModelToController = {
            self.createMarker(list: self.homeViewModel.sensor)
        }
    }
    
    func createMarker(list:[SensorResponse]){
        DispatchQueue.main.async {
            for sensor in list{
                self.sensorList.append(sensor)
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: sensor.latitude, longitude: sensor.longitude)
                marker.title = sensor.description
                marker.map = self.mapView
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
    }
}
