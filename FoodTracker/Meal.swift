//
//  Meal.swift
//  FoodTracker
//
//  Created by vasanth vmr on 12/29/15.
//  Copyright © 2015 vasanth vmr. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
    // MARK: Properties
    var name:String
    var rating:Int
    var image:UIImage?
    struct propertyTypes {
        static let nameKey = "name"
        static let imageKey = "image"
        static let ratingKey = "rating"
    }
    
    // MARK: Archiving Paths
    static let DirectoryPath = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let archivePath = DirectoryPath.URLByAppendingPathComponent("meal")
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: propertyTypes.nameKey)
        aCoder.encodeObject(image, forKey: propertyTypes.imageKey)
        aCoder.encodeInteger(rating, forKey: propertyTypes.ratingKey)
    }
    
    // MARK: Intialization
    init?(name:String , rating:Int , image:UIImage?){
        self.name = name
        self.rating = rating
        self.image = image
        super.init()
        // Initialization should fail if name is empty or rating is negative 
        if(name.isEmpty || rating < 0){
            return nil
        }
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let decode_rating = aDecoder.decodeIntegerForKey(propertyTypes.ratingKey)
        let decode_name = aDecoder.decodeObjectForKey(propertyTypes.nameKey) as! String
        let decode_image = aDecoder.decodeObjectForKey(propertyTypes.imageKey) as? UIImage
        self.init(name: decode_name,rating: decode_rating,image: decode_image)
    }
}
