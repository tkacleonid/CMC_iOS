//
//  ForecastViewModel.swift
//  Weather
//
//  Created by Leonid Tkachenko on 22/11/2017.
//  Copyright © 2017 Leonid Tkachenko. All rights reserved.
//

import Foundation

class ForecastViewModel {
    class DayForecast {
        var items = [DayWeatherViewModel]()
        var day = "1 November"
    }
    
    class DayWeatherViewModel {
        var weather = DayWeather()
        var time = "00:00"
        var iconData: Data?
        
        var imageLoaded: ((Data) -> Void)?
        
        init(dayWeather: DayWeather) {
            weather = dayWeather
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            time = dateFormatter.string(from: dayWeather.date)
        }
        
        func loadImage() {
            WeatherAPI.iconDataWithName(path: weather.image) { (data) in
                guard let data = data else { return }
                sleep(3)
                self.iconData = data
                self.imageLoaded?(data)
            }
        }
        
    }
    
    
    
    var dailyForecasts = [DayForecast]()
    var location: String
    
    
    var viewModelChanged: (() -> Void)?
    
    init(location: String) {
        self.location = location

    }
    
    
    func loadForecast() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM"
        
        let forecast = Forecast()
        
        WeatherAPI.loadHourForecast(location: location, forecastP: forecast, calback: { () -> Void in
            
            for i in 0...forecast.items.count-1 {
                let d = (i/24) as Int
                if(i % 24 == 0) {
                    self.dailyForecasts.append(DayForecast())
                }
                self.dailyForecasts[d].day = dateFormatter.string(from: forecast.items[i].date)
                self.dailyForecasts[d].items.append(DayWeatherViewModel(dayWeather: forecast.items[i]))
            }
            self.viewModelChanged!()
            
            
        })

    }
}

