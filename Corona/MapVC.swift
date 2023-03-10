//
//  MapVC.swift
//  Corona
//
//  Created by Gizem Melisa Ates on 5/4/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController {
    
    var data = ""
    var crrdata = ""
    var date = ""
    var crrdate = ""

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self as? MKMapViewDelegate
        checkLocationServices()
        crrdata = data
        crrdate = date
    }
    //for result prompt
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MapVCtoResultsVC"){
            let resultsvc = segue.destination as! ResultsVC
            resultsvc.message = crrdata
            resultsvc.date = crrdate
        }
    }
    
    func findHospital() {
        let request = MKLocalSearch.Request();
        request.naturalLanguageQuery = "Hospital"
        request.region = mapView.region
        let search = MKLocalSearch(request: request);
        search.start(completionHandler: searchHandler)
    }
    
    func searchHandler (response: MKLocalSearch.Response?, error: Error?) {
        if let err = error {
            print("Error occured in search: \(err.localizedDescription)");
            
        } else if let resp = response {
            print("\(resp.mapItems.count) matches found")
            self.mapView.removeAnnotations(self.mapView.annotations)
            for item in resp.mapItems {
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocationAuthorization()
        }else{//show alert to let user know they hey to turn it on
        }
    }
    
    func ActionAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: {(action) in self.navigationController?.popViewController(animated: true)});
        alert.addAction(okAction);
        alert.preferredAction = okAction; // only affects .alert style
        present(alert, animated: true, completion: nil);
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            findHospital()
            break
        case .denied, .restricted:
            // Show alert instructing them how to turn on permissions
            ActionAlert(title: "Location Unavailable", message: "Authorize location services for this app in device settings")
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000)
            mapView.setRegion(region, animated: true)
        }
    }
}

extension MapVC: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
