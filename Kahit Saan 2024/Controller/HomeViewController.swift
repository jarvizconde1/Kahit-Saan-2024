//
//  ViewController.swift
//  Kahit Saan 2024
//
//  Created by Jarvis Vizconde on 10/19/24.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController  {

    @IBOutlet weak var locationLabel: UILabel!
    
    
    let locationManager = CLLocationManager()
    var nearbyPlacesManager = NearbyPlacesManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
    
    
    @IBAction func getLocation(_ sender: Any) {
        print("Get Location Pressed")
        locationManager.requestLocation()
        
    }
    
    
    @IBAction func searchButton(_ sender: Any) {
        
    }
    
}

//MARK: -  LOCATION MANAGER DELEGATE

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingHeading()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
           
            
            
            //call the protocol - do action using lat / lon
            nearbyPlacesManager.fetchNearbyPlaces(latitude: lat, longitude: lon)
            
            let coordinates = CLLocationCoordinate2D(latitude: lat , longitude: lon)
            getAddressFromCoordinates(coordinate: coordinates) { address in
                if let address = address {
                   // print("Address: \(address)")
                    self.locationLabel.text = ("\(address)")
                } else {
                    self.locationLabel.text = ("GPS not found")
                }
            }
            
            
          
         }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print (error)
    }
    
    
    

    
    
}

