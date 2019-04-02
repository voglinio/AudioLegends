//
//  Placemark.swift
//  AudioLegends
//
//  Created by Konstantinos Vogklis on 02/04/2019.
//  Copyright © 2019 Konstantinos Vogklis. All rights reserved.
//

import Foundation

struct Placemark {
    let name : String
    let audio: (spaw: String, norm: String, died: String)
    let coords: (latitude: Double, longitude: Double)
    let trajectory: String
    let speed : Int
    let gain : Float
}

extension Placemark {
    init?(json: [String: Any]) {
        print (json["name"], json["speed"], json["gain"], json["trajectory"] )
        
        print("-----------")
        guard let name = json["name"] as? String,
            let coordinatesJSON = json["coords"] as? [String: Double],
            let latitude = coordinatesJSON["lati"],
            let longitude = coordinatesJSON["long"],
            let audioSON = json["audio"] as? [String: String],
            let spaw = audioSON["spaw"],
            let norm = audioSON["norm"],
            let died = audioSON["died"],
            let speed = json["speed"] as? Int,
            let gain = json["gain"] as? Float,
            let trajectory = json["trajectory"] as? String
            
        
            else {
                print ("error")
                return nil
        }
        
        
        self.name = name
        self.coords = (latitude, longitude)
        self.audio = (spaw, norm, died)
        self.gain = gain
        self.speed = speed
        self.trajectory = trajectory
    }
}

class Placemarks{
    var placemarks: [Placemark] = []
    
    func loadInitialData(){
        // 1
        guard let fileName = Bundle.main.path(forResource: "placemarks", ofType: "json")
            else { return }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName), options: .mappedIfSafe)

        guard
            let data = optionalData,
            // 2
            let json = try? JSONSerialization.jsonObject(with: data) ,
            // 3
            let dictionary = json as? [Any]
            // 4
            //let works = dictionary["data"] as? [[Any]]
            else { return }

        // 5
        let validPlacemarks = dictionary.compactMap { Placemark(json: $0 as! [String : Any] ) }
        placemarks.append(contentsOf: validPlacemarks)
        
    }

}

