//
//  VenueTableViewCell.swift
//  Weather
//
//  Created byLeonid Tkachenko on 12/4/17.
//  Copyright © 2017 Leonid Tkachenko. All rights reserved.
//

import UIKit

class VenueTableViewCell: UITableViewCell {
    private var vn: VenuesViewModel.VenueViewModel?
    
    @IBOutlet weak var UrlLinkButton: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func openLink(_ sender: Any) {
        if let url = URL(string: (vn?.venue.link)!) {
            UIApplication.shared.open(url, options: [:])
        }
     
    }

    
    func configure(with vn: VenuesViewModel.VenueViewModel) {
       
        nameLabel.text = vn.venue.name
        rankLabel.text = String(vn.venue.rank)
        addressLabel.text = vn.venue.address
        
        
        
        self.vn = vn
        
    
        
        self.vn?.imageLoaded = { [weak self] data in
            DispatchQueue.main.async {
                self?.indicatorView.stopAnimating()
                self?.iconImageView.image = UIImage(data: data)
            }
        }
        
        
        self.indicatorView.startAnimating()
        self.vn?.loadImage()
 
 
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconImageView.image = nil
        vn?.imageLoaded = nil
        vn = nil
    }

}
