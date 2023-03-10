//
//  NearbyVC.swift
//  FavFoodHw5
//
//  Created by Gizem Melisa Ates on 3/25/20.
//  Copyright © 2020 Gizem Melisa Ates. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class NearbyVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate
{
    
    var foodName: String!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var promptLabel: UILabel!
    var locationManager = CLLocationManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.locationManager.delegate = self;
        self.mapView.delegate = self;
        promptLabel.text = foodName
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        initializeLocation()
    
    }
    
    func initializeLocation() { // called from start up method locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        switch status {
            case .authorizedAlways, .authorizedWhenInUse:
                        findFood()
            case .denied, .restricted:
                ActionAlert(title: "Location Unavailable", message: "Authorize location services for this app in device settings")
            
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
        }
        
    }
    
    
    func ActionAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: {(action) in self.navigationController?.popViewController(animated: true)});
        alert.addAction(okAction);
        alert.preferredAction = okAction; // only affects .alert style
        present(alert, animated: true, completion: nil);
    }
    
    func findFood() {
        let request = MKLocalSearch.Request();
        request.naturalLanguageQuery = promptLabel.text
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
