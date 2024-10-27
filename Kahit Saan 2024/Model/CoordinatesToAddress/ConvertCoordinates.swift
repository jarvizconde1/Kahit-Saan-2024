//
//  ViewController.swift
//  Kahit Saan 2024
//
//  Created by Jarvis Vizconde on 10/19/24.
//

import CoreLocation



//Converting Address From coordinates
func getAddressFromCoordinates(coordinate: CLLocationCoordinate2D, completion: @escaping (String?) -> Void) {
    let geocoder = CLGeocoder()
    let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

    geocoder.reverseGeocodeLocation(location)
    { placemarks, error in
        if let error = error {
            print("Reverse geocoding failed: \(error.localizedDescription)")
            completion(nil)

            return
        }

        guard let placemark = placemarks?.first else {
            completion(nil)
            return
        }

        //  address components as needed
        let streetName = placemark.thoroughfare ?? ""
        let city = placemark.locality ?? ""
        let state = placemark.administrativeArea ?? ""
       
        // Construct the full address string
        let address = "\(streetName),\(city),\(state)"

        completion(address)
    }
}
