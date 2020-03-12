//
//  Game.swift
//  MemoryCard
//
//  Created by tima on 3/11/20.
//  Copyright © 2020 MemoryCard. All rights reserved.
//
import Foundation
import UIKit

class Game {
  
  //MARK: Properties
  
  var delegate: GameProtocol?
  var cards:[Card] = [Card]()
  var cardsShown:[Card] = [Card]()
  var isPlaying: Bool = false
  
  //MARK: Functions
  
  func newGame(cardsArray:[Card]) -> [Card] {
    cards = cardsArray.shuffled()
    isPlaying = true
    delegate?.memoryGameDidStart(self)
    return cards
  }
  
  func restartGame() {
    isPlaying = false
    cards.removeAll()
    cardsShown.removeAll()
  }
  
  func indexForCard(_ card: Card) -> Int? {
    for index in 0...cards.count-1 {
      if card === cards[index] {
        return index
      }
    }
    return nil
  }
  
  func didSelectCard(_ card: Card?) {
    guard let card = card else { return }
    
    delegate?.memoryGame(self, showCards: [card])
    if unmatchedCardShown() {
      let unmatched = unmatchedCard()!
      if card.equals(unmatched) {
        cardsShown.append(card)
        Constants.score+=10
      } else {
        let secondCard = cardsShown.removeLast()
        let delayTime = DispatchTime.now() + 1.0
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
          self.delegate?.memoryGame(self, hideCards:[card, secondCard])
        }
      }
    } else {
      cardsShown.append(card)
    }
    
    if cardsShown.count == cards.count {
      endGame()
    }
  }
  
  func endGame() {
    self.isPlaying = false
    delegate?.memoryGameDidEnd(self)
  }
  
  func cardAtIndex(_ index: Int) -> Card? {
    if cards.count > index {
      return cards[index]
    } else {
      return nil
    }
  }
  func unmatchedCardShown() -> Bool {
    return cardsShown.count % 2 != 0
  }
  
  func unmatchedCard() -> Card? {
    let unmatchedCard = cardsShown.last
    return unmatchedCard
  }
  
  
}
