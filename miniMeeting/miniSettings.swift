//
//  miniSettings.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 20/02/2021.
//

import SwiftUI
import UserNotifications

struct miniSettings: View {
    var body: some View {
       
            Form{
                
                Section(header: Text("Notifications")) {
                    
                    Button("Request Permission") {
                        
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                            if success {
                                print("All set!")
                            } else if let error = error {
                                print(error.localizedDescription)
                            }
                        }
                        
                    }
                    
                }
                
            }.navigationTitle("Settings")
        
    }
}

struct miniSettings_Previews: PreviewProvider {
    static var previews: some View {
        miniSettings()
    }
}
