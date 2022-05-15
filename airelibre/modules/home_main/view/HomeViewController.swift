//
//  HomeViewController.swift
//  airelibre
//
//  Created by LucasG on 2022-04-12.
//

import UIKit
import GoogleMaps

class HomeViewController: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate {

    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var viewMap: UIView!
    
    @IBOutlet weak var tvInfoDescription: UILabel!
    @IBOutlet weak var tvInfoScale: UILabel!
    @IBOutlet weak var tvInfoTitle: UILabel!
    @IBOutlet weak var tvInfoEmoji: UILabel!
    @IBOutlet weak var viewInfoSensor: UIView!
    @IBOutlet weak var btnCloseInfoSensor: UIButton!
    
    private var homeViewModel:HomeViewModel!
    private var sensorList:[SensorResponse] = []
    private var sensor:SensorResponse!
    
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
        configureUI()
        gestureDownInfoMarker()
    }
    
    @IBAction func clickSensorInfoClose(_ sender: Any) {
        UIView.animate(
            withDuration: 0.9,
            delay: 0.0,
            options: .curveLinear,
            animations: {
                self.viewInfoSensor?.frame.origin.y = 10000

        }) { (completed) in
            self.viewInfoSensor?.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        markerTheme()
        configureUI()
    }
    
    private func configureUI(){
        if self.traitCollection.userInterfaceStyle == .dark {
            tvTitle.textColor = .white
        }else{
            tvTitle.textColor = .black
        }
        
    }

    private func createMap(){
        let camera = GMSCameraPosition.camera(withLatitude: -25.250, longitude: -57.536, zoom: 10)
        mapView = GMSMapView.map(withFrame: self.viewMap.frame, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        markerTheme()
        self.viewMap.addSubview(mapView)
    }
    
    private func markerTheme(){
        if self.traitCollection.userInterfaceStyle == .dark {
            do {
                if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                  mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                } else {
                  NSLog("Unable to find style.json")
                }
              } catch {
                NSLog("One or more of the map styles failed to load. \(error)")
            }
        } else {
            mapView.mapStyle = nil
        }
    }
    
    private func callService(){
        self.homeViewModel = HomeViewModel()
        self.homeViewModel.bindHomeViewModelToController = {
            self.createMarker(list: self.homeViewModel.sensor)
        }
    }
    
    private func createMarker(list:[SensorResponse]){
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
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let markerObj = sensorList.filter {$0.description.contains(marker.title!)}
         if(marker != nil){
             mapView.selectedMarker = marker
             onClickInfoSensor(sensor: markerObj[0])
         }
            
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        if let location = locations.last{
            var flagLocation = Double.greatestFiniteMagnitude
            sensorList.forEach { SensorResponse in
                let locationCercano = location.distance(from: CLLocation(latitude: SensorResponse.latitude, longitude: SensorResponse.longitude))
                if(locationCercano < flagLocation){
                    flagLocation = locationCercano
                    sensor = SensorResponse
                }
            }
            if(sensor != nil){
                if(self.viewInfoSensor?.isHidden == true){
                    onClickInfoSensor(sensor: sensor)
                }
            }
        }
    }
    
    private func createMarkerWithText(_ index: Int) -> UIImage {
        let color = UIColor.black
        let title = "\(UInt(index))"
        let attrs: [NSAttributedString.Key: Any] = [.foregroundColor: color]
        let attrStr = NSAttributedString(string: title, attributes: attrs)
        let image = self.markerImage(index: index)!
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(image.size.width), height: CGFloat(image.size.height)))
        var ejeX = 18
        switch(String(index).count){
            case 2: ejeX = 15
            case 3: ejeX = 13
            default: break
        }
        let rect = CGRect(x: CGFloat(ejeX), y: CGFloat(5), width: CGFloat(image.size.width), height: CGFloat(image.size.height))

        attrStr.draw(in: rect)

        let markerImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return markerImage
    }
    
    private func markerImage(index:Int)-> UIImage?{
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
    
    private func emojiScale(index:Int)->String{
        switch(index){
            case 0...50: return "🟢👍"
            case 51...100: return "🟡😐"
            case 101...150: return "🟠⚠"
            case 151...200: return "🔴⚠"
            case 201...300:  return "🟣☣️"
            default: return "🟤☠️"
        }
    }
    
    private func slideUpInfo(){
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: .curveLinear,
            animations: {
                self.viewInfoSensor?.frame.origin.y = -100
        })
    }
    
    private func onClickInfoSensor(sensor:SensorResponse){
        mapView.camera = GMSCameraPosition.camera(withLatitude: sensor.latitude, longitude: sensor.longitude, zoom: 10)
        tvInfoTitle.text = sensor.description
        tvInfoScale.text = "\(sensor.quality.index)"
        tvInfoEmoji.text = emojiScale(index: sensor.quality.index)
        self.viewInfoSensor?.isHidden = false
        slideUpInfo()
    }
    
    private func gestureDownInfoMarker(){
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        downSwipe.direction = .down
        viewInfoSensor.addGestureRecognizer(downSwipe)
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if (sender.direction == .down) {
            UIView.animate(
                withDuration: 1,
                delay: 0.0,
                options: .curveLinear,
                animations: {
                    self.viewInfoSensor?.frame.origin.y = 10000

            }) { (completed) in
                self.viewInfoSensor?.isHidden = true
            }
        }
    }
}
