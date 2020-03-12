//
//  CardProvider.swift
//  MemoryCard
//
//  Created by tima on 3/11/20.
//  Copyright © 2020 MemoryCard. All rights reserved.
//
import UIKit

class CardProvider {
  
  //MARK: Private initializer
  private init(){}
  
  //MARK: Global property(Singleton)
  static let shared = CardProvider()
  
  //MARK: Functions
  func getCards() -> [Card] {
    var array = [Card]()
    for i in 1...8 {
      let card = Card(image: UIImage(named: "item_\(i)") ?? UIImage())
      let copy = card.copy()
      array.append(card)
      array.append(copy)
    }
    return array
  }
}
