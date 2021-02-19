//
//  miniEventFormView.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 18/02/2021.
//

import SwiftUI

struct miniEventFormView: View {
    
    @ObservedObject var eventCellViewModel: EventCellViewModel

    var onCommit: (Event) -> (Void) = {_ in}
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        
        NavigationView{
            Form{
                miniCard(eventCellViewModel: eventCellViewModel)

                Section(header: Text("Event")) {
                    
                    TextField("Name", text: $eventCellViewModel.event.name)
                    TextField("Category", text: $eventCellViewModel.event.category)
                    
//                    TextField("From Hour", value: $eventCellViewModel.event.fromHour, formatter: NumberFormatter())
                    
                    
                    HStack {
                        Text("From Hour:")
                        NumberTextField(value: $eventCellViewModel.event.fromHour)
                    }
                    
                    HStack {
                        Text("To Hour:")
                        NumberTextField(value: $eventCellViewModel.event.toHour)
                    }
                    
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
            }.listStyle(GroupedListStyle()).navigationTitle("New Event")
            
        }
    }
}

struct miniEventFormView_Previews: PreviewProvider {
    static var previews: some View {
        miniEventFormView(eventCellViewModel: EventCellViewModel(event: Event(name: "Teste", fromHour: 0, toHour: 0, category: "teste", backgroundColor: .blue, textColor: .black)))
    }
}
