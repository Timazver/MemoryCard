//
//  AppDelegate.swift
//  MemoryCard
//
//  Created by tima on 3/11/20.
//  Copyright © 2020 MemoryCard. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var userDefaults = UserDefaults.standard
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "VC")
    Constants.score = userDefaults.integer(forKey: "SCORE")
    return true
  }
  
}

