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
        let draggableBackground1: DraggableViewBackground = DraggableViewBackground(frame: self.view.frame)
        vc1.view.addSubview(draggableBackground1)
        let vc2 = sb.instantiateViewController(withIdentifier: "menteeVC")
        let draggableBackground2: DraggableViewBackground = DraggableViewBackground(frame: self.view.frame)
        vc2.view.addSubview(draggableBackground2)
        
        
        
        return [vc1, vc2]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        
        // Do any additional setup after loading the view.
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    }

