//
//  CategoryRepository.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 27/02/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase


class CategoryRepository: ObservableObject {
    
    let db = Firestore.firestore()
    static let shared = CategoryRepository()
    
    @Published var categories = [Category]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        let userId = Auth.auth().currentUser?.uid
        
        db.collection("categories")
            .whereField("userId", isEqualTo: userId)
            .order(by: "createdTime")
            .addSnapshotListener { (querySnapshot, error) in

            if let querySnapshot = querySnapshot {

                self.categories = querySnapshot.documents.compactMap{ document in

                    do{

                        let x = try document.data(as: Category.self)

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
    
    func addCategory(_ category: Category){
        do{
            var addedCategory = category
            addedCategory.userId = Auth.auth().currentUser?.uid
            
            let _ = try db.collection("categories").addDocument(from: addedCategory)
        }
        catch{
            fatalError("Unable to encode category: \(error.localizedDescription)")
        }
    }
    
    func updateCategory(_ category: Category){
        if let categoryID = category.id {
            do{
                try db.collection("categories").document(categoryID).setData(from: category)
            }catch {
                fatalError("Unable to encode category: \(error.localizedDescription)")
            }
        }
    }
    
}

