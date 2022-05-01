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
                marker.icon = self.createMarkerWithText(sensor.quality.index)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
    }
    
    func createMarkerWithText(_ index: Int) -> UIImage {
        let color = UIColor.black
        let string = "\(UInt(index))"
        let attrs: [NSAttributedString.Key: Any] = [.foregroundColor: color]
        let attrStr = NSAttributedString(string: string, attributes: attrs)
        let image = self.markerImage(index: index)!
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(image.size.width), height: CGFloat(image.size.height)))
        var ejeX = 18
        if(index >= 10){ ejeX = 15}
        let rect = CGRect(x: CGFloat(ejeX), y: CGFloat(5), width: CGFloat(image.size.width), height: CGFloat(image.size.height))

        attrStr.draw(in: rect)

        let markerImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return markerImage
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
    
    
}
