//
//  ForecastCellView.swift
//  Weather
//
//  Created by Leonid Tkachenko on 22/11/2017.
//  Copyright © 2017 Leonid Tkachenko. All rights reserved.
//

import UIKit

class ForecastCellView: UITableViewCell {
    private var viewModel: ForecastViewModel.DayWeatherViewModel?
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet weak var humadityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    
    func configure(with viewModel: ForecastViewModel.DayWeatherViewModel) {
        temperatureLabel.text = String(viewModel.weather.temperature) + " ºC"
        pressureLabel.text = String(viewModel.weather.pressure) + " мм.рт.ст."
        humadityLabel.text = String(viewModel.weather.humidity) + " %"
        windLabel.text = String(viewModel.weather.wind) + " м/c"
        timeLabel.text = String(describing: viewModel.time)
        self.viewModel = viewModel
        
       
        self.viewModel?.imageLoaded = { [weak self] data in
            DispatchQueue.main.async {
                self?.indicatorView.stopAnimating()
                self?.iconImageView.image = UIImage(data: data)
            }
        }
 
        
        self.indicatorView.startAnimating()
        self.viewModel?.loadImage()
 
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconImageView.image = nil
        viewModel?.imageLoaded = nil
        viewModel = nil
    }
}





