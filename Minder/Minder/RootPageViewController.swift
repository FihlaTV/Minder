//
//  RootPageViewController.swift
//  Minder
//
//  Created by Shameemah on 7/15/17.
//  Copyright © 2017 Minder. All rights reserved.
//

import UIKit

class RootPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var users: [User] = []
    
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
        makeUsers()
        
        for view in self.view.subviews{
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
        
        if let firstViewController = viewControllerList.first { self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func makeUsers() {
        let user1 = User("Ahmed", "ahmed@example.com", "originalsomaliangangster","123Kjsk", URL(string: "https://pbs.twimg.com/profile_images/770632212492333056/K6BfTfK6_400x400.jpg")!, 22, "Student", "UW",0)
        let user2 = User("Ivory", "ivory@exmple.com", "blueivy","jBebji34", URL(string: "https://pbs.twimg.com/profile_images/770632212492333056/K6BfTfK6_400x400.jpg")!, 20, "Student", "Duke",2)
        let user3 = User("Kim", "kim@example.com", "kimkardashian","Sbdsos123", URL(string: "https://pbs.twimg.com/profile_images/868831562665783296/616PUnnV_400x400.jpg")!, 15, "Student", "San Fran",1)
        let user4 = User("Shameemah", "sham@example.com", "shameemah","Shammy123", URL(string: "https://media2.s-nbcnews.com/j/newscms/2016_48/1178509/halima-aden-miss-usa-today-161130-tease_820708b331a5564b54db86dd93e6be1d.today-inline-large.jpg")!, 24, "Engineer", "Illanois Tech",0)
        let user5 = User("Kofi", "kofi@example.com", "kofiman","Kofi123", URL(string: "http://www4.pictures.zimbio.com/gi/Kofi+Siriboe+2nd+Annual+InStyle+Awards+Arrivals+v7YJer8GrSql.jpg")!, 19, "Engineer", "UW",1)
        
        users.append(user1)
        users.append(user2)
        users.append(user3)
        users.append(user4)
        users.append(user5)
        
        

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

