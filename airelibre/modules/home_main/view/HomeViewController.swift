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
    private var showSensorFavorite:Bool = true
    private var theme = UserDefaults.standard.string(forKey: "isDarkMode")
    
    private let manager = CLLocationManager()
    private var mapView:GMSMapView!
    private var zoomGet:Float = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        createMap()
        callService()
        configureUI()
        gestureDownInfoMarker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mapTheme()
        configureUI()
        themeApp()
        showSensorFavorite = true
    }
    
    @IBAction func clickSensorInfoClose(_ sender: Any) {
        self.viewInfoSensor?.isHidden = true
    }
    
    @IBAction func clickInfoAQI(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let myAlert = storyboard.instantiateViewController(withIdentifier: "dialogAQI")
                myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.present(myAlert, animated: true, completion: nil)
        
    }
    
    
    private func configureUI(){
        if(theme == nil){
            if(self.traitCollection.userInterfaceStyle == .dark){
                tvTitle.textColor = .white
            }else{
                tvTitle.textColor = .black
            }
        }else{
            if(theme == "Dark"){
                tvTitle.textColor = .white
            }else{
                tvTitle.textColor = .black
            }
        }
    }

    private func createMap(){
        let camera = GMSCameraPosition.camera(withLatitude: -25.250, longitude: -57.536, zoom: zoomGet)
        mapView = GMSMapView.map(withFrame: self.viewMap.frame, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        mapTheme()
        self.viewMap.addSubview(mapView)
    }
    
    private func mapTheme(){
        theme = UserDefaults.standard.string(forKey: "isDarkMode")
        if(theme == nil){
            if self.traitCollection.userInterfaceStyle == .dark {
                do {
                    if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                      mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                    }
                  } catch {
                    NSLog("One or more of the map styles failed to load. \(error)")
                  }
            } else {
                mapView.mapStyle = nil
            }
        }else{
            if(theme == "Dark"){
                do {
                    if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                      mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                    }
                  } catch {
                    NSLog("One or more of the map styles failed to load. \(error)")
                  }
            }else{
                mapView.mapStyle = nil
            }
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
                marker.snippet = self.qualityScaleText(index: sensor.quality.index)
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
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        zoomGet = position.zoom
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        if let location = locations.last{
            if(showSensorFavorite){
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
                showSensorFavorite = false
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
        image.draw(in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(image.size.width+10), height: CGFloat(image.size.height+10)))
        var ejeX = 23
        switch(String(index).count){
            case 2: ejeX = 20
            case 3: ejeX = 16
            default: break
        }
        let rect = CGRect(x: CGFloat(ejeX), y: CGFloat(7), width: CGFloat(image.size.width), height: CGFloat(image.size.height))

        attrStr.draw(in: rect)

        let markerImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return markerImage
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
        mapView.camera = GMSCameraPosition.camera(withLatitude: sensor.latitude, longitude: sensor.longitude, zoom: zoomGet)
        var animationON = true
        if(tvInfoTitle.text == sensor.description){animationON = false}
        tvInfoTitle.text = sensor.description
        tvInfoScale.text = "\(sensor.quality.index)"
        tvInfoEmoji.text = self.emojiScale(index: sensor.quality.index)
        self.viewInfoSensor?.isHidden = false
        if(animationON){slideUpInfo()}else{
            self.viewInfoSensor?.isHidden = false
        }
    }
    
    private func gestureDownInfoMarker(){
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        downSwipe.direction = .down
        viewInfoSensor.addGestureRecognizer(downSwipe)
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if (sender.direction == .down) {
            self.viewInfoSensor?.isHidden = true
        }
    }
}
