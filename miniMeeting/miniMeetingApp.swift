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
    
    UIApplication.shared.applicationIconBadgeNumber = 0
    UserDefaults.standard.set(0, forKey: "NotificationBadgeCount")

    return true
  }
    
//    func applicationDidBecomeActive(_ application: UIApplication) {
//        UIApplication.shared.applicationIconBadgeNumber = 0
//        UserDefaults.standard.set(0, forKey: "NotificationBadgeCount")
//    }
    
    
}

@main
struct miniMeetingApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
      
      init() {
        FirebaseApp.configure()
        Auth.auth().signInAnonymously()
      }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
//                miniEventDetailView(event: Event( name: "PISID - Teórica", category: "Favorites", date: Date(), fromHour: Date(), toHour: Date(), backgroundColor: UIColor(red: 252/255, green: 227/255, blue: 138/255, alpha: 1).toSwiftUIColor, textColor: UIColor(red: 218/255, green: 115/255, blue: 60/255, alpha: 1).toSwiftUIColor, link: URL(string: "https://www.google.pt")))
//                ContentView()
                miniCategoryView()
            }
        }
        .onChange(of: scenePhase){ newScenePhase in
            switch newScenePhase{
            case .active:
                    print("---- App is active")
                    UIApplication.shared.applicationIconBadgeNumber = 0
                    UserDefaults.standard.set(0, forKey: "NotificationBadgeCount")

                  case .inactive:
                    print("---- App is inactive")
                  case .background:
                    print("---- App is in background")
                  @unknown default:
                    print("---- Oh - interesting: I received an unexpected new value.")
            }
            
        }
    }
}
