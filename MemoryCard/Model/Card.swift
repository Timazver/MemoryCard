//
//  Card.swift
//  MemoryCard
//
//  Created by tima on 3/11/20.
//  Copyright © 2020 MemoryCard. All rights reserved.
//
import UIKit

class Card {
  var id: String
  var isShown: Bool
  var image: UIImage!
  
  //MARK: Init implementations
  init(image: UIImage) {
    self.id = UUID().uuidString
    self.isShown = false
    self.image = image
  }
  
  init(card: Card) {
    self.id = card.id
    self.isShown = card.isShown
    self.image = card.image
  }
  
  //MARK: functions
  func equals(_ card: Card) -> Bool {
    return (card.id == id)
  }
  
  func copy() -> Card {
    return Card(card: self)
  }
  
}
