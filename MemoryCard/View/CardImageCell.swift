//
//  CardImageCell.swift
//  MemoryCard
//
//  Created by tima on 3/11/20.
//  Copyright © 2020 MemoryCard. All rights reserved.
//

import UIKit

class CardImageCell: UICollectionViewCell {
  
  // MARK: Properties
  var isShown: Bool = false
  var card: Card? {
    didSet {
      guard let card = card else { return }
      frontImageView.image = card.image
      
      frontImageView.layer.cornerRadius = 5.0
      backImageView.layer.cornerRadius = 5.0
      
      frontImageView.layer.masksToBounds = true
      backImageView.layer.masksToBounds = true
    }
  }
  
  //MARK: Outlets
  @IBOutlet private weak var frontImageView: UIImageView!
  @IBOutlet private weak var backImageView: UIImageView!
  
  //MARK: Functions
  
  
  func showCard(_ show: Bool, animated: Bool) {
    frontImageView.isHidden = false
    backImageView.isHidden = false
    isShown = show
    
    if animated {
      if show {
        UIView.transition(
          from: backImageView,
          to: frontImageView,
          duration: 0.5,
          options: [.transitionFlipFromRight, .showHideTransitionViews],
          completion: { (finished: Bool) -> () in
        })
      } else {
        UIView.transition(
          from: frontImageView,
          to: backImageView,
          duration: 0.5,
          options: [.transitionFlipFromRight, .showHideTransitionViews],
          completion:  { (finished: Bool) -> () in
        })
      }
    } else {
      if show {
        bringSubviewToFront(frontImageView)
        backImageView.isHidden = true
      } else {
        bringSubviewToFront(backImageView)
        frontImageView.isHidden = true
      }
    }
  }
}
