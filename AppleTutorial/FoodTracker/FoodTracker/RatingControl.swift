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
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        // call method change rating
        didSet {
            updateButtonSelectionStates()
        }
    }
    
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
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
    
    
    // MARK: Private Methods
    private func setupButtons() {
        // clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // 이미지 로드시키기
        // the control is @IBDesignable, the setup code also needs to run in Interface Builder
        let bundle = Bundle(for: type(of: self)) // assets에 있는 이미지를 가리킴
        // init(named:in:compatibleWith:) > in에 해당 named를 가지고 있는 compatibleWith의 이미지를 가져옴
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0 ..< starCount {
            let button = UIButton()
            // set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted,.selected])
            
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
            ratingButtons.append(button)
        }
        // update the button’s selection state whenever buttons are added to the control
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() {
        for (index,button) in ratingButtons.enumerated() {
            print(ratingButtons)
            button.isSelected = index < rating
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
