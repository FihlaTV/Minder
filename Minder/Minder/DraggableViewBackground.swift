//
//  DraggableViewBackground.swift
//  Minder
//
//  Created by Kofi  Sekyi-Appiah on 7/15/17.
//  Copyright © 2017 Minder. All rights reserved.
//

import Foundation
import UIKit
import ReachabilitySwift


class DraggableViewBackground: UIView, DraggableViewDelegate {
    var exampleCardLabels = [String]()
    var actualCardLabels = [String]()
    var allCards: [DraggableView]!
    var myWebView: UIWebView!
    
    let MAX_BUFFER_SIZE = 2
    let CARD_HEIGHT: CGFloat = 386
    let CARD_WIDTH: CGFloat = 350
    
    
    var cardsLoadedIndex: Int!
    var loadedCards: [DraggableView]!
    var menuButton: UIButton!
    var messageButton: UIButton!
    var checkButton: UIButton!
    var xButton: UIButton!
    var expandButton: UIButton!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.layoutSubviews()
        self.setupView()
        
        exampleCardLabels = []
        
        for i in 0 ..< 10000 {
            
            exampleCardLabels.append("No Internet Connection")
        }
        actualCardLabels = []
        allCards = []
        loadedCards = []
        cardsLoadedIndex = 0
        self.loadCards()
    }
    
    func setupView() -> Void {
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        xButton = UIButton(frame: CGRect(x: (self.frame.size.width - CARD_WIDTH)/2 + 45, y: self.frame.size.height/2 + CARD_HEIGHT/2 + 35, width: 70, height: 70))
        xButton.setImage(UIImage(named: "xButton"), for: UIControlState())
        xButton.addTarget(self, action: #selector(DraggableViewBackground.swipeLeft), for: UIControlEvents.touchUpInside)
        
        checkButton = UIButton(frame: CGRect(x: self.frame.size.width/2 + CARD_WIDTH/2 - 110, y: self.frame.size.height/2 + CARD_HEIGHT/2 + 35, width: 70, height: 70))
        checkButton.setImage(UIImage(named: "checkButton"), for: UIControlState())
        checkButton.addTarget(self, action: #selector(DraggableViewBackground.swipeRight), for: UIControlEvents.touchUpInside)
        
        
        
        self.addSubview(xButton)
        self.addSubview(checkButton)
        
        
        
    }
    
    func createDraggableViewWithDataAtIndex(_ index: NSInteger) -> DraggableView {
        let draggableView = DraggableView(frame: CGRect(x: (self.frame.size.width - CARD_WIDTH)/2, y: (self.frame.size.height - CARD_HEIGHT)/2, width: CARD_WIDTH, height: CARD_HEIGHT))
        draggableView.information.text = exampleCardLabels[index]
        
        draggableView.information.adjustsFontSizeToFitWidth = true
        draggableView.information.numberOfLines = 10
        draggableView.delegate = self
        return draggableView
    }
    
    func loadCards() -> Void {
        if exampleCardLabels.count > 0 {
            let numLoadedCardsCap = exampleCardLabels.count > MAX_BUFFER_SIZE ? MAX_BUFFER_SIZE : exampleCardLabels.count
            for i in 0 ..< exampleCardLabels.count {
                let newCard: DraggableView = self.createDraggableViewWithDataAtIndex(i)
                
                allCards.append(newCard)
                
                if i < numLoadedCardsCap {
                    loadedCards.append(newCard)
                    let reachability = Reachability()
                    if reachability.isInternetAvailable() == true {
                        newCard.display()
                    } else {
                        print("Internet connection FAILED")
                        let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
                        alert.show()
                    }
                    
                }
                
            }
            
            for i in 0 ..< loadedCards.count {
                if i > 0 {
                    self.insertSubview(loadedCards[i], belowSubview: loadedCards[i - 1])
                    
                } else {
                    self.addSubview(loadedCards[i])
                }
                cardsLoadedIndex = cardsLoadedIndex + 1
            }
        }
    }
    
    func cardSwipedLeft(_ card: UIView) -> Void {
        loadedCards.remove(at: 0)
        let reachability = Reachability()
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            if reachability.isInternetAvailable() == true {
                allCards[cardsLoadedIndex].display()
                cardsLoadedIndex = cardsLoadedIndex + 1
                self.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
            } else {
                print("Internet connection FAILED")
                let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
            
            
        }
    }
    
    func cardSwipedRight(_ card: UIView) -> Void {
        loadedCards.remove(at: 0)
        
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            let reachability = Reachability()
            if reachability.isInternetAvailable() == true {
                allCards[cardsLoadedIndex].display()
                cardsLoadedIndex = cardsLoadedIndex + 1
                self.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
            } else {
                print("Internet connection FAILED")
                let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
            
        }
    }
    
    
    
    func swipeRight() -> Void {
        if loadedCards.count <= 0 {
            return
        }
        let dragView: DraggableView = loadedCards[0]
        dragView.overlayView.setMode(GGOverlayViewMode.ggOverlayViewModeRight)
        UIView.animate(withDuration: 0.2, animations: {
            () -> Void in
            dragView.overlayView.alpha = 1
        })
        dragView.rightClickAction()
    }
    
    func swipeLeft() -> Void {
        if loadedCards.count <= 0 {
            return
        }
        let dragView: DraggableView = loadedCards[0]
        dragView.overlayView.setMode(GGOverlayViewMode.ggOverlayViewModeLeft)
        UIView.animate(withDuration: 0.2, animations: {
            () -> Void in
            dragView.overlayView.alpha = 1
        })
        dragView.leftClickAction()
    }
    
    
    
    
    
}
