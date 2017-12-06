//
//  ViewController.swift
//  Weather
//
//  Created by Leonid Tkachenko on 18/10/2017.
//  Copyright © 2017 Leonid Tkachenko. All rights reserved.
//

import UIKit


extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

class ViewController: UIViewController {
    
    var weather = DayWeather()
    
    
    
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var curWeatherBurron: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        curWeatherBurron.sendActions(for:.touchUpInside)
    }
    
    @IBAction func getCurrentWether(_ sender: UIButton) {
        
        
        let sv = UIViewController.displaySpinner(onView: self.view)
 

        WeatherAPI.loadCurrentWeather(weatherP: weather, calback: { () -> Void in
            
    
            DispatchQueue.main.async() {
                
                self.cityLabel.text = self.weather.city
                self.temperatureLabel.text = String(self.weather.temperature)
                self.windLabel.text = String(self.weather.wind)
                self.humidityLabel.text = String(self.weather.humidity)
                self.pressureLabel.text = String(self.weather.pressure)
                
                self.img.image = UIImage(data: self.weather.imageData!)
                
                UIViewController.removeSpinner(spinner: sv)
                
            }
            
            
        })
        
    }
    
    @IBAction func getWether(_ sender: UIButton) {
        let weatherTag = sender.tag
        
        let sv = UIViewController.displaySpinner(onView: self.view)
        
        
        WeatherAPI.loadWeather(tag: weatherTag, weatherP: weather, calback: { () -> Void in
            
            DispatchQueue.main.async() {
                
                self.cityLabel.text = self.weather.city
                self.temperatureLabel.text = String(self.weather.temperature)
                self.windLabel.text = String(self.weather.wind)
                self.humidityLabel.text = String(self.weather.humidity)
                self.pressureLabel.text = String(self.weather.pressure)
                
                self.img.image = UIImage(data: self.weather.imageData!)
                
                UIViewController.removeSpinner(spinner: sv)
                
            }
            
            
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch (identifier) {
            case "HourForecastSegue":
                if let vc = segue.destination as? ForecastTableView {
                   vc.location = self.weather.cityEng
                }
            case "showVenuesSegue":
                if let vc = segue.destination as? VenueTableViewController {
                    vc.location = self.weather.cityEng
                }


            default:
                break
            }
        }
    }

}

