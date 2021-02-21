//
//  miniEventFormView.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 18/02/2021.
//

import SwiftUI

struct miniEventFormView: View {
    
    @ObservedObject var eventCellViewModel: EventCellViewModel

    var jaExiste : Bool = false
    var multipleCategories : [String]
    var onCommit: (Event) -> (Void) = {_ in}
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedStrength = "Mild"
       
    var body: some View {
        
        NavigationView{
            Form{
                
                VStack {
                    HStack {
                        Text(eventCellViewModel.event.category)
                            .fontWeight(.bold).foregroundColor(eventCellViewModel.event.backgroundColor)
                        Spacer()
                    }.padding([.leading, .trailing, .top])
                    
                    miniCard(eventCellViewModel: eventCellViewModel)
                }

                Section(header: Text("Name 🏷")){
                    TextField("Name", text: $eventCellViewModel.event.name)
                }
                
                Section(header: Text("Category 📦")){
                    TextField("Category", text: $eventCellViewModel.event.category)
                    
                    HStack {
                        Text("Created categories:")
                        Spacer()
                        Picker("Strength", selection: $selectedStrength) {
                                                ForEach(multipleCategories, id: \.self) {
                                                    Text($0)
                                                }
                        }.pickerStyle(MenuPickerStyle())
                    }
                }
                
                Section(header: Text("Hours ⏰")){
                    HStack {
                        Text("From Hour:")
                        NumberTextField(value: $eventCellViewModel.event.fromHour)
                    }
                    
                    HStack {
                        Text("To Hour:")
                        NumberTextField(value: $eventCellViewModel.event.toHour)
                    }
                }
                
                Section(header: Text("Style 😎")) {
//                    TextField("From Hour", value: $eventCellViewModel.event.fromHour, formatter: NumberFormatter())
//                    TextField("To Hour", value: $eventCellViewModel.event.toHour, formatter: NumberFormatter())
                    
                    //                DatePicker("From Hour", selection: $fromHour, displayedComponents: .hourAndMinute)
                    //
                    //                DatePicker("To Hour", selection: $toHour, displayedComponents: .hourAndMinute)
                    ColorPicker("Background Color", selection: $eventCellViewModel.event.backgroundColor)
                    ColorPicker("Text Color", selection: $eventCellViewModel.event.textColor)
                    
                    Button("Save changes") {
                        
                        self.onCommit(self.eventCellViewModel.event)
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                }
            }.listStyle(GroupedListStyle()).navigationTitle("Edit")
            
        }
    }
}

struct miniEventFormView_Previews: PreviewProvider {
    static var previews: some View {
        miniEventFormView(eventCellViewModel: EventCellViewModel(event: Event(name: "", fromHour: 0, toHour: 0, category: "teste", backgroundColor: .blue, textColor: .black)), multipleCategories: ["C1","C2","C3"])
    }
}
