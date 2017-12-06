//
//  ForecastViewModel.swift
//  Weather
//
//  Created by Leonid Tkachenko on 22/11/2017.
//  Copyright © 2017 Leonid Tkachenko. All rights reserved.
//

import Foundation

class VenuesViewModel {
    
    class VenueViewModel {
        var venue = Venue()
        var iconData: Data?
        
        var imageLoaded: ((Data) -> Void)?
        
        init(vn: Venue) {
           venue = vn
        }
        
        func loadImage() {
            VenueAPI.iconDataWithName(path: venue.image) { (data) in
                guard let data = data else { return }
                sleep(3)
                self.iconData = data
                self.imageLoaded?(data)
            }
        }
        
    }

    var items = [VenueViewModel]()
    var location: String
    
    
    var viewModelChanged: (() -> Void)?
    
    init(location: String) {
        self.location = location
        
    }
    
    
    func loadVenues() {
        
        VenueAPI.loadTopVenues(location: location, venuesP: self, calback: { () -> Void in
    
            self.viewModelChanged?()
        
        })
        
    }
    
}


