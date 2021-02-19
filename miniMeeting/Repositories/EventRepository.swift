//
//  EventRepository.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 18/02/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase


class EventRepository: ObservableObject {
    
    let db = Firestore.firestore()
    static let shared = EventRepository()
    
    @Published var events = [Event]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        let userId = Auth.auth().currentUser?.uid
        
        db.collection("events")
            .whereField("userId", isEqualTo: userId)
            .order(by: "createdTime")
            .addSnapshotListener { (querySnapshot, error) in

            if let querySnapshot = querySnapshot {

                self.events = querySnapshot.documents.compactMap{ document in

                    do{

                        let x = try document.data(as: Event.self)

                        return x
                    }
                    catch{
                        print(error)
                    }
                    return nil
                }
                
            }
        }
    }
    
    func addEvent(_ event: Event){
        do{
            var addedEvent = event
            addedEvent.userId = Auth.auth().currentUser?.uid
            
            let _ = try db.collection("events").addDocument(from: addedEvent)
        }
        catch{
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
    }
    
    func updateEvent(_ event: Event){
        if let eventID = event.id {
            do{
                try db.collection("events").document(eventID).setData(from: event)
            }catch {
                fatalError("Unable to encode event: \(error.localizedDescription)")
            }
        }
    }
    
}
