//
//  Constants.swift
//  MemoryCard
//
//  Created by tima on 3/11/20.
//  Copyright © 2020 MemoryCard. All rights reserved.
//
import UIKit

class Constants {
  static var appDelegate = UIApplication.shared.delegate as! AppDelegate
  static let defaultAlertTitle = "Великолепно!"
  static let defaultAlertMessage = "Играем снова?"
  static var score: Int = 0 {
    didSet {
      print(score)
      appDelegate.userDefaults.set(score, forKey: "SCORE")
    }
  }
}
