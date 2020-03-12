//
//  ViewController.swift
//  MemoryCard
//
//  Created by tima on 3/11/20.
//  Copyright © 2020 MemoryCard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  //MARK: properties
  private var cards = [Card]()
  private var cellIndex = 0
  private let game = Game()
  private let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
  
  //MARK: Outlets
  @IBOutlet private weak var collectionView: UICollectionView!
  @IBOutlet private weak var score: UILabel!
  
  //MARK: IBActions
  @IBAction func onStartGame(_ sender: Any) {
    collectionView.isHidden = false
    //      setupNewGame()
  }
  
  //MARK: Functions
  
  override func viewDidLoad() {
    super.viewDidLoad()
    score.text = "Ваши очки: \(Constants.score)"
    game.delegate = self
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.isHidden = true
    cards = CardProvider.shared.getCards()
    setupNewGame()
  }
  
  func setupNewGame() {
    cards = game.newGame(cardsArray: self.cards)
    collectionView.reloadData()
  }
  
  func resetGame() {
    game.restartGame()
    setupNewGame()
  }
  
  
}

extension ViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as! CardImageCell
    if cell.isShown {
      return
    }
    game.didSelectCard(cell.card)
    score.text = "Ваши очки: \(Constants.score)"
    collectionView.deselectItem(at: indexPath, animated:true)
  }
  
}

extension ViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cards.count
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardImageCell
    cell.showCard(false, animated: false)
    
    guard let card = game.cardAtIndex(indexPath.item) else { return cell }
    
    cell.card = card
    
    return cell
    
  }
  
  
  
  
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let paddingSpace = Int(sectionInsets.left) * 4
    let availableWidth = Int(view.frame.width) - paddingSpace
    let widthPerItem = availableWidth / 4
    
    return CGSize(width: widthPerItem, height: widthPerItem)
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
    
  }
}

extension ViewController: GameProtocol {
  
  func memoryGameDidStart(_ game: Game) {
    collectionView.reloadData()
  }
  
  func memoryGameDidEnd(_ game: Game) {
    let alertController = UIAlertController(
      title: Constants.defaultAlertTitle,
      message: Constants.defaultAlertMessage,
      preferredStyle: .alert)
    
    let cancelAction = UIAlertAction(title: "Неа", style: .cancel) { [weak self] (action) in
      self?.collectionView.isHidden = true
    }
    let playAgainAction = UIAlertAction(title: "Да!", style: .default) { [weak self] (action) in
      self?.collectionView.isHidden = true
      self?.resetGame()
    }
    
    alertController.addAction(cancelAction)
    alertController.addAction(playAgainAction)
    
    self.present(alertController, animated: true) { }
    
    resetGame()
  }
  
  func memoryGame(_ game: Game, showCards cards: [Card]) {
    for card in cards {
      guard let index = game.indexForCard(card) else { return }
      let cell = collectionView.cellForItem(at: IndexPath(item: index, section:0)) as! CardImageCell
      cell.showCard(true, animated: true)
    }
  }
  
  func memoryGame(_ game: Game, hideCards cards: [Card]) {
    for card in cards {
      guard let index = game.indexForCard(card) else { continue }
      let cell = collectionView.cellForItem(at: IndexPath(item: index, section:0)) as! CardImageCell
      cell.showCard(false, animated: true)
    }
  }
  
  
}
