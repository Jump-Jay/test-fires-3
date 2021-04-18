//
//  ViewController.swift
//  test fires 3
//
//  Created by Jason M Davis on 4/12/21.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    let whereAmI = CLLocationManager()

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      mapView?.showsUserLocation = true
      whereAmI.requestWhenInUseAuthorization()
      whereAmI.delegate = self
      whereAmI.startUpdatingLocation()
      updateLocation(whereAmI.location)
    }
   
    func updateLocation(_ location: CLLocation?) {
      guard let location = location, let mapView = mapView else { return }
      guard !(location.coordinate.longitude == 0 && location.coordinate.latitude == 0) else { return }

      let span = MKCoordinateSpan(latitudeDelta: 0.4 , longitudeDelta: 0.4)
      let rawRegion = MKCoordinateRegion(center: location.coordinate, span: span)
      let region = mapView.regionThatFits(rawRegion)
      mapView.setRegion(region, animated: true)
    }
    
    @objc
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       updateLocation(locations.first)
     }
    
    
}

