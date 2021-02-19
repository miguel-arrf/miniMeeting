//
//  miniMeetingApp.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 18/02/2021.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    print("App Delegate.")
    
    return true
  }
}

@main
struct miniMeetingApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
      
      init() {
        FirebaseApp.configure()
        Auth.auth().signInAnonymously()
      }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }
        }
    }
}
