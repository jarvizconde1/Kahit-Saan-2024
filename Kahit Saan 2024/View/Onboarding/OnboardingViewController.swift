//
//  OnboardingViewController.swift
//  Kahit Saan 2024
//
//  Created by Jarvis Vizconde on 10/19/24.
//

import UIKit

class OnboardingViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
   
    @IBOutlet weak var nextButton: UIButton!
    
    var slides : [OnboardingSlide] = []
    var currentPages =  0 {
        didSet  {
            pageControl.currentPage = currentPages
            if currentPages == slides.count - 1 {
                    nextButton.setTitle("Get Started", for: .normal)
                }else {
                    nextButton.setTitle("Next", for: .normal  )
                }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        slides = [
                    OnboardingSlide(title: "Delicious Dishes", description: "Experience a variety of amazing dishes from different cultures around the world.", image: (UIImage(named:"slide1") ?? UIImage(named: "slide1")!)),
                    
                    
                    OnboardingSlide(title: "World-Class Chefs", description: "Our dishes are prepared by only the best.", image: (UIImage(named:"slide2") ?? UIImage(named: "slide2")!)),
                    
                    
                    
                    OnboardingSlide(title: "Instant World-Wide Delivery", description: "Your orders will be delivered instantly irrespective of your location around the world.", image: (UIImage(named:"slide3") ?? UIImage(named: "slide3")!))
                ]
        
    }
    

   
    @IBAction func buttonClicked(_ sender: UIButton) {
       
        if currentPages == slides.count - 1 {
         
        print ("last page")
            let controller = storyboard?.instantiateViewController(withIdentifier: "homeNC") as! UINavigationController
            present(controller, animated: true)
            
        }else{
            currentPages += 1
        
            let indexPaths = IndexPath(item:currentPages, section: 0)
           
          //bug in collectionView, must disable paging then disable it
            collectionView.isPagingEnabled = false
            self.collectionView.scrollToItem(at: indexPaths, at: .centeredHorizontally, animated: true)
            collectionView.isPagingEnabled = true
           
            
           
        
        }
        
    }
    
}


//MARK: -  extension
extension OnboardingViewController : UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier , for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setup(slide: slides[indexPath.row])
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height)
    }
    
  
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPages = Int(scrollView.contentOffset.x / width)
        
            
    }
    
}
