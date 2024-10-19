//
//  OnboardingCollectionViewCell.swift
//  Kahit Saan 2024
//
//  Created by Jarvis Vizconde on 10/19/24.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = ("OnboardingCollectionViewCell")
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitle: UILabel!
    @IBOutlet weak var slideDescription: UILabel!
    
    func setup( slide : OnboardingSlide){
        
        slideTitle.text = slide.title
        slideDescription.text = slide.description
        slideImageView.image = slide.image
        
    }
}

