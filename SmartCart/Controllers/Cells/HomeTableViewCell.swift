//
//  HomeTableViewCell.swift
//  SmartCart
//
//  Created by Yasir Tahir Ali on 28/12/2020.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblManufacturer: UILabel!
    @IBOutlet weak var lblAvailability: UILabel!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var imgHolder: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgHolder.layer.cornerRadius = 10
        imgHolder.layer.masksToBounds = true
        imgHolder.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
