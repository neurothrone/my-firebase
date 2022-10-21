//
//  MY_FirebaseApp.swift
//  MY-Firebase
//
//  Created by Zaid Neurothrone on 2022-10-21.
//

import FirebaseCore
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct MY_FirebaseApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        ContentView()
      }
    }
  }
}
