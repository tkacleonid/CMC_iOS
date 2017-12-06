//
//  WeatherAPI.swift
//  Weather
//
//  Created by Leonid Tkachenko on 11/7/17.
//  Copyright © 2017 Leonid Tkachenko. All rights reserved.
//

import Foundation


class VenueAPI
{
    static let API_ADDRESS = "https://api.foursquare.com/v2/venues/explore?v=20161016&venuePhotos=1"
    static let section = "outdoors"
    static let intent = "checkin"
    static let client_id = "IF4WLVQBJEKD5RQY1SNE2LIENZ5GUOY43SG1LQALO2XZAI1T"
    static let client_secret = "2U1W1JUA5BW0B54U2E2FDBCC2PCPSKTNZL5I3HX0OA4T4200"
    
    static func getApiAdress(city: String) -> String{
        return "\(API_ADDRESS)&near=\(city)&section=\(section)&intent=\(intent)&client_id=\(client_id)&client_secret=\(client_secret)"
    }

    
    static func loadTopVenues(location: String, venuesP: VenuesViewModel, calback: @escaping () -> Void) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let url = URL(string: VenueAPI.getApiAdress(city: location))!
        
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request,
                                    completionHandler: { data, response, error in
                                        
                                        guard let data = data, error == nil else {
                                            print("error=\(String(describing: error))")
                                            return
                                        }
                                        
                                        
                                        let json = try? JSONSerialization.jsonObject(with: data, options: [])
                                        
                                        if let dictionary = json as? [String: Any] {
                                             if let resp = dictionary["response"] as? [String: Any] {
                                                if let groups = resp["groups"] as? [[String: Any]] {
                                                    let group0 = groups[0]
                                                    if let items = group0["items"] as? [[String: Any]] {
                                                            for i in 0...items.count - 1 {
                                                                let vn = Venue()
                                                                if let venue = items[i]["venue"] as? [String: Any] {
                                                                    vn.name = venue["name"] as! String
                                                                    if((venue["rating"] as? Double) == nil) {
                                                                        continue
                                                                    }
                                                                    vn.rank = (venue["rating"] as? Double)!
                                                                    if let featuredPhotos = venue["featuredPhotos"] as? [String: Any] {
                                                                        if let photos = featuredPhotos["items"] as? [[String: Any]] {
                                                                            let photo = photos[0] as [String: Any]
                                                                          
                                                                            let prefix = photo["prefix"] as? String
                                                                            let suffix = photo["suffix"] as? String
                                                                            vn.image = prefix! + "500x500" + suffix!

                                                                        }
                                                                    }
                                                                    if((venue["url"] as? String) == nil) {
                                                                        continue
                                                                    }
                                                                    vn.link = (venue["url"] as? String)!
                                                                    if let location = venue["location"] as? [String: Any] {
                                                                        if let formattedAddress = location["formattedAddress"] as? [String] {
                                                                            for i in 0...formattedAddress.count - 1 {
                                                                                let addr = formattedAddress[i]
                                                                                vn.address = vn.address + addr + "\n"
                                                                            }
                                                                        }
                                                                        
            
                                                                    }
                                                                    
                                                                }
                                                                venuesP.items.append(VenuesViewModel.VenueViewModel(vn: vn))
                                                            }
                                                        }
                                                    
                                                }
                                            }
                     
                                        }
                                        calback()
                                        
                                        
        })
        
        task.resume()
        
    }
    
    static func iconDataWithName(path: String, completionHandler: @escaping ((Data?) -> Void)) {
        let urlString = path
        guard let url = URL(string: urlString) else {
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let data = try? Data(contentsOf: url)
            completionHandler(data)
        }
    }
    
}

