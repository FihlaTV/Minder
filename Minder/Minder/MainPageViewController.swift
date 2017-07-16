//
//  MainPageViewController.swift
//  Minder
//
//  Created by Kimberly R McIver on 7/15/17.
//  Copyright © 2017 Minder. All rights reserved.
//

import Foundation
import UIKit

class MainPageViewController: UIViewController {
    @IBAction func chooseMentor(_ sender: Any) {
      
        if let rootPageViewController = self.childViewControllers.first as? RootPageViewController{
        
            rootPageViewController.setViewControllers([rootPageViewController.viewControllerList[mentorpicker.selectedSegmentIndex]], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        }
    }

    @IBOutlet weak var mentorpicker: UISegmentedControl!
    @IBOutlet weak var mainPageView: UIView!

}
