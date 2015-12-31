//
//  RatingControl.swift
//  FoodTracker
//
//  Created by vasanth vmr on 12/29/15.
//  Copyright © 2015 vasanth vmr. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    var rating = 0{
        didSet{
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    let spacing = 5
    let stars = 5
    
    // MARK: Intialization
    required init?(coder aDecoder: NSCoder) {
        // Call Super class init
        super.init(coder: aDecoder)
        let emptyStarImage = UIImage(named: "emptyStar")
        let filledStartImage = UIImage(named: "filledStar")
        for _ in 0..<stars{
            // Create button for rating
            let button = UIButton(/*frame: CGRect(x: 0, y: 0, width: 44, height: 44)*/)//Since frame is set in layoutSubView
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStartImage, forState: .Selected)
            button.setImage(filledStartImage, forState: [.Selected,.Highlighted])
            
            //button.backgroundColor = UIColor.redColor()
            
            button.addTarget(self, action: "ratingButtonTapped:", forControlEvents: .TouchDown)
            
            ratingButtons+=[button]
            //Add the button to this sub class view
            addSubview(button)
        }
    }
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize+spacing)*stars
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Actions
    func ratingButtonTapped(button:UIButton){
        rating = ratingButtons.indexOf(button)!+1
        updateButtonSelectionStatus()
    }
    func updateButtonSelectionStatus(){
        for (index,button) in ratingButtons.enumerate(){
            button.selected = index<rating
        }
    }
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        //Offset the each button origin by the lenght of previous button + spacing
        for (index,button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index*(buttonSize+spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectionStatus()
    }
}
