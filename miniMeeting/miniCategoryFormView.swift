//
//  miniCategoryFormView.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 27/02/2021.
//

import SwiftUI

struct miniCategoryFormView: View {
    
    @ObservedObject var categoryViewModel : CategoryViewModel
    var onCommit: (Category) -> (Void) = {_ in}
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
      
            Form{
                
                Section(header: Text("Icon")){
                    HStack(){
                        Group{
                            Text("🤩")
                            Spacer()
                            
                            Text("😎")
                            Spacer()
                            
                            Text("🚀")
                            Spacer()
                        }
                        Text("😚")
                        Spacer()
                        
                        Text("🎓")
                        Spacer()
                        
                        Text("🤓")
                        
                    }
                }
                
                Section(header: Text("Hours ⏰").padding(.top)){
                    TextField("Name", text: $categoryViewModel.category.name)
                }
                
                Section(header: Text("Style 😎")) {
                    ColorPicker("Background Color", selection: $categoryViewModel.category.backgroundColor)
                    ColorPicker("Text Color", selection: $categoryViewModel.category.textColor)
                }
                
                Section{
                    Button("Save changes") {
                        
                        self.onCommit(self.categoryViewModel.category)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }.listStyle(GroupedListStyle()).navigationTitle(categoryViewModel.category.name)
            .navigationBarTitleDisplayMode(.inline)

        
    }
}

struct miniCategoryFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            miniCategoryFormView(categoryViewModel: CategoryViewModel(category: Category( name: "Escola", backgroundColor: .orange, textColor: .blue)))
        }

    }
}
