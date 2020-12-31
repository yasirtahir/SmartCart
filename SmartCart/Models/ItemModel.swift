//
//  ItemModel.swift
//  SmartCart
//
//  Created by Yasir Tahir Ali on 21/11/2020.
//

import Foundation
import UIKit

public class ItemModel : NSObject {
    
    var title : String? = ""
    var category : String? = ""
    var manufacturer : String? = ""
    var imageURL : String? = ""
    var availability : String? = ""
    
    init(title : String, category : String, manufacturer : String, imageURL : String, availability : String) {
        self.title = title
        self.category = category
        self.manufacturer = manufacturer
        self.imageURL = imageURL
        self.availability = availability
    }
    
    func getTitle() -> String {
        return title != nil && !title!.isEmpty ? title! : ""
    }
    
    func getCategory() -> String {
        return category != nil && !category!.isEmpty ? category! : ""
    }
    
    func getManufacturer() -> String {
        return manufacturer != nil && !manufacturer!.isEmpty ? manufacturer! : ""
    }
    
    func getImageURL() -> String {
        return imageURL != nil && !imageURL!.isEmpty ? imageURL! : ""
    }
    
    func getAvailability() -> String {
        return availability != nil && !availability!.isEmpty ? availability! : ""
    }
    
    func setAvailability(value: String) {
        self.availability = value
    }
}
