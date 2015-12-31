//
//  Meal.swift
//  FoodTracker
//
//  Created by vasanth vmr on 12/29/15.
//  Copyright © 2015 vasanth vmr. All rights reserved.
//

import UIKit

class Meal {
    // MARK: Properties
    var name:String
    var rating:Int
    var image:UIImage?
    
    
    // MARK: Intialization
    init?(name:String , rating:Int , image:UIImage?){
        self.name = name
        self.rating = rating
        self.image = image
        
        // Initialization should fail if name is empty or rating is negative 
        if(name.isEmpty || rating < 0){
            return nil
        }
    }
}
