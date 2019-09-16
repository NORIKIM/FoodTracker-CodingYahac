//
//  Meal.swift
//  FoodTracker
//
//  Created by 김지나 on 21/08/2019.
//  Copyright © 2019 김지나. All rights reserved.
//

import UIKit
import os.log

//Data model for a meal
class Meal: NSObject, NSCoding {
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Archiving Paths
    // DocumentsDirectory : 파일 관리자의 URL(for:in:) 방법을 사용하여 앱 문서 디렉토리의 URL을 검색한다. 이것은 앱이 사용자를 위해 데이터를 저장할 수 있는 디렉토리 이다.
    // 문서 디렉터리의 URL을 결정한 후 이 URL을 사용하여 응용 프로그램 데이터의 URL을 생성하십시오. 여기서, 당신은 식사를 문서 URL의 끝에 추가하여 파일 URL을 만든다.
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    // MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
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
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        // Meal 클래스에 있는 각 속성의 값을 인코딩하고 해당하는 키로 저장한다.
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    // required : 서브클래스에 이니셜라이저가 정의 되면, 모든 서브클래스에서 동작해야한다는 의미
    // convenience : 두번째 이니셜라이져 이며, 현재 클래스의 지정이니셜라이져는 반드시 불려야 한다는 의미
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)

        self.init(name: name, photo: photo, rating: rating)
    }
}
