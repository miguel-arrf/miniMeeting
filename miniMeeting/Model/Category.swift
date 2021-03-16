//
//  Category.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 27/02/2021.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Category: Codable, Identifiable{
    @DocumentID var id: String?
    var name: String
    
    var backgroundColor: Color
    var textColor: Color
    
    var emoji:String
    
    var userId : String?
    @ServerTimestamp var createdTime: Timestamp?
    
}
