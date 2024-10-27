//
//  UrlManager.swift
//  Kahit Saan 2024
//
//  Created by Jarvis Vizconde on 11/3/24.
//

import Foundation


protocol PlacesManagerDelegate {
   
    func didFailWithError ( error : Error)
  
}

struct NearbyPlacesManager {
    
    var delegate : PlacesManagerDelegate?
    
    let apiKey = "AIzaSyBgiaNgs2SUlnzgedam2ocQ66g4wPuNgJo"
    
    let nearbyURL  = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
    
    
    
    //sample url
//        https://maps.googleapis.com/maps/api/place/nearbysearch/json?
//        keyword=food
//        &type=restaurant
//        &key=AIzaSyBgiaNgs2SUlnzgedam2ocQ66g4wPuNgJo
//        &rankby=distance
//        &location=15.027059575284186%2C120.93593261585168
//    
//    
    
   
    func fetchNearbyPlaces(latitude: Double, longitude: Double ) {
        
        let urlString = nearbyURL + "keyword=food&type=restaurant&key=\(apiKey)&rankby=distance&location=\(latitude),\(longitude)"
        performRequest(with: urlString)
    }
    
    
    
    func performRequest (with urlString : String){
        //4 steps of networking//
        
        //1.Create a URL
        if let url = URL(string: urlString){
            
            //2.Create a URLsession
            let session = URLSession(configuration: .default)
            
            //3. Give session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    
                    return
                }
                
                if let safeData = data {
                    //transfer decoded data to view controller
                    if let locationArray = self.parseJSON(JsonData: safeData) {
                      //  self.delegates?.weatherDidUpdate(self, weather: weather)
                        print(locationArray)
                    }
                    
                }
             }
            
            //4.Start the task
            task.resume()
        }
    }
    
    
    
    
    //parse JSON FILE
    
    func parseJSON( JsonData  : Data) -> PlacesModel? {
        
        let jsonDecoder = JSONDecoder()
        do {
          let decodedData =  try jsonDecoder.decode( PlacesJSONData.self , from: JsonData)
            
           
            
            
         //   let count = (decodedData.results.count)
            
            let placeID = (decodedData.results[0].place_id)
            let name = (decodedData.results[0].name)
            let status = (decodedData.results[0].opening_hours.open_now)
            let rating = (decodedData.results[0].rating)
            let priceLevel = (decodedData.results[0].price_level)
            
            let locationListArray = PlacesModel(placeID: placeID, name: name, rating: rating, status: status, priceLevel: priceLevel)
            
          //  print (locationListArray)
            return locationListArray
            
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
    
}
