//
//  RootPageViewController.swift
//  Minder
//
//  Created by Shameemah on 7/15/17.
//  Copyright © 2017 Minder. All rights reserved.
//

import UIKit

class RootPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    lazy var viewControllerList:[UIViewController] = {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "mentorVC")
        let vc2 = sb.instantiateViewController(withIdentifier: "menteeVC")
        
        
        return [vc1, vc2]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        
        for view in self.view.subviews{
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
        
        if let firstViewController = viewControllerList.first { self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    

     //func didReceiveMemoryWarning() {
       // super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
       // func pageViewController(<#T##pageViewController: UIPageViewController##UIPageViewController#>, viewControllerBefore: <#T##UIViewController#>)
    
    
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            
            guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
            
            let previousIndex = vcIndex - 1
            
            guard previousIndex >= 0 else {return nil}
            
            guard viewControllerList.count > previousIndex else {return nil}
            
            return viewControllerList[previousIndex]
            
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            
            guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
            
            let nextIndex = vcIndex + 1
            
            guard viewControllerList.count != nextIndex else { return nil}
            
            guard viewControllerList.count > nextIndex else { return nil}
            
            return viewControllerList[nextIndex]
        }
    }

