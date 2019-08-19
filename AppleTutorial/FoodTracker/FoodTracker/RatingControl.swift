//
//  RatingControl.swift
//  FoodTracker
//
//  Created by 김지나 on 11/08/2019.
//  Copyright © 2019 김지나. All rights reserved.
//

import UIKit

// 코드로 UI 구현
@IBDesignable class RatingControl: UIStackView {
    // MARK: Properties
    private var ratingButton = [UIButton]()
    var rating = 0
    
    // didSet : update the control, reset the control’s buttons every time these attributes change. can be used to perform work immediately before or after the value changes.
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    
    // MARK: Button Action
    @objc func ratingButtonTapped(button: UIButton) {
        print("button pressed!!!!!")
    }
    
    
    // MARK: Private Methods
    private func setupButtons() {
        // clear any existing buttons
        for button in ratingButton {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButton.removeAll()
        
        for _ in 0 ..< starCount {
            // create the button
            let button = UIButton()
            button.backgroundColor = UIColor.red
            
            // add contraints
            // define the button as a fixed-size object in your layout (44 point x 44 point).
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // setup the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // add the button to the stack
            addArrangedSubview(button)
            
            // add the new button to the rating button arrary
            ratingButton.append(button)
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
