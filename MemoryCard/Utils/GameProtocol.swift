//
//  GameProtocol.swift
//  MemoryCard
//
//  Created by tima on 3/11/20.
//  Copyright © 2020 MemoryCard. All rights reserved.
//

protocol GameProtocol {
  func memoryGameDidStart(_ game: Game)
  func memoryGameDidEnd(_ game: Game)
  func memoryGame(_ game: Game, showCards card: [Card])
  func memoryGame(_ game: Game, hideCards cards: [Card])
}
