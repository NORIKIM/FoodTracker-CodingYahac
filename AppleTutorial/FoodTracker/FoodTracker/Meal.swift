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
        if name.isEmpty || rating < 0 {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
