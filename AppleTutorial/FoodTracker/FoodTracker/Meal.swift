//
//  Meal.swift
//  FoodTracker
//
//  Created by 김지나 on 21/08/2019.
//  Copyright © 2019 김지나. All rights reserved.
//

import UIKit

class Meal {
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
