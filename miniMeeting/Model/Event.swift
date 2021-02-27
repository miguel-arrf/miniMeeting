//
//  event.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 18/02/2021.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Event: Codable, Identifiable{
    @DocumentID var id : String?
    var name: String
    
    var category: String
    
    var date : Date
    var fromHour : Date
    var toHour : Date
    
    var backgroundColor: Color
    var textColor: Color
    
    var link:URL?
    
    var userId : String?
    @ServerTimestamp var createdTime: Timestamp?
}



#if DEBUG
let testDataEvents = [
    Event(name: "PISID - Teórica", category: "Favorites", date: Date(), fromHour: Date(), toHour: Date(), backgroundColor: UIColor(red: 252/255, green: 227/255, blue: 138/255, alpha: 1).toSwiftUIColor, textColor: UIColor(red: 218/255, green: 115/255, blue: 60/255, alpha: 1).toSwiftUIColor),
    
    Event(name: "IPM - Prática", category: "School", date: Date(), fromHour: Date(), toHour: Date(), backgroundColor: UIColor(red: 174/255, green: 225/255, blue: 225/255, alpha: 1).toSwiftUIColor, textColor: UIColor(red: 129/255, green: 161/255, blue: 161/255, alpha: 1).toSwiftUIColor),
    
    Event(name: "DECD", category: "Others", date: Date(), fromHour: Date(), toHour: Date(), backgroundColor: UIColor(red: 182/255, green: 182/255, blue: 182/255, alpha: 0.6).toSwiftUIColor, textColor: UIColor(red: 129/255, green: 161/255, blue: 161/255, alpha: 1).toSwiftUIColor)
]
#endif



extension UIColor {
    var toSwiftUIColor: Color {
        Color(self)
    }
        
}
