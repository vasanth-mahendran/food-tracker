//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by vasanth vmr on 12/26/15.
//  Copyright © 2015 vasanth vmr. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    func testMealIntialization(){
        //Success Case
        let successMeal = Meal(name: "Salad", rating: 5, image: nil)
        XCTAssertNotNil(successMeal)
        
        //Failure Case
        let nameFailureMeal = Meal(name: "", rating: 5, image: nil)
        XCTAssertNil(nameFailureMeal)
        
        let ratingFailureMeal = Meal(name: "Sambhar", rating: -5, image: nil)
        XCTAssertNil(ratingFailureMeal)
    }
}
