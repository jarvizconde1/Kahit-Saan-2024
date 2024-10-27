//
//  Untitled.swift
//  Kahit Saan 2024
//
//  Created by Jarvis Vizconde on 11/15/24.
//


struct PlacesJSONData : Codable {
    
    let results : [Results]
}

struct Results : Codable {
    let name : String
    let place_id : String
    let opening_hours : OpeningHours
    let rating : Float?
    let price_level : Float?
   
}
struct OpeningHours : Codable {
    let open_now : Bool
}





