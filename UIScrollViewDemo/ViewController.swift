//
//  ViewController.swift
//  UIScrollViewDemo
//
//  Created by AdBox on 5/25/17.
//  Copyright © 2017 myth. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    
    // add feature data to dictionary
    let feature_1 = ["title":"iPhone 5", "price":"$-499", "image":"1"]
    let feature_2 = ["title":"iPhone 6s", "price":"$-699", "image":"2"]
    let feature_3 = ["title":"iPhone 7", "price":"$-899", "image":"3"]
    
    var array_features = [Dictionary<String,String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
       
        //add feature dictionary to an array
        array_features = [feature_1,feature_2,feature_3]
        
        scrollView.isPagingEnabled = true
        //set scrollview content size
        scrollView.contentSize = CGSize(width: self.view.frame.width * CGFloat(array_features.count), height: 430)
        scrollView.showsHorizontalScrollIndicator = false
        
        loadFeatures()
    }
    
    func loadFeatures() {
    
        for (index, feature) in array_features.enumerated() {
            
            if let featureView = Bundle.main.loadNibNamed("Feature", owner: self, options: nil)?.first as? FeatureView {
            
                featureView.iv_featureImage.image = UIImage(named: feature["image"]!)
                featureView.lb_title.text = feature["title"]!
                featureView.lb_price.text = feature["price"]!
                //add tag number to identify the button
                featureView.btn_addToCart.tag = index
                featureView.btn_addToCart.addTarget(self, action: #selector(addToCart(sender:)), for: .touchUpInside)
                
                scrollView.addSubview(featureView)
                //add width of featureview width
                featureView.frame.size.width = self.view.bounds.size.width
                //add content x poition
                featureView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
            }
        }
    }
    
    func addToCart(sender :UIButton) {
    
        print("Add to cart item \(sender.tag)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // get the current scroll page index and set to page controller
        let page = scrollView.contentOffset.x / scrollView.frame.width
        pageController.currentPage = Int(page)
    }
}

