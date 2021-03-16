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
    
    @State private var showingAlert = false
    
    @ObservedObject var selectedColor : ColorSelected = ColorSelected()
    
    var body: some View {
        
        NavigationView{
            Form{
                
                VStack {
                    //                    HStack {
                    //                        Text(eventCellViewModel.event.category)
                    //                            .fontWeight(.bold).foregroundColor(eventCellViewModel.event.backgroundColor)
                    //                        Spacer()
                    //                    }.padding([.leading, .trailing, .top])
                    
                    miniCard(eventCellViewModel: eventCellViewModel).padding(.vertical)
                }
                
                Section(header: Text("Name 🏷")){
                    TextField("Name", text: $eventCellViewModel.event.name)
                }
                
                Section(header: Text("Category 📦")){
                    
                    Toggle("Set category", isOn: $eventCellViewModel.event.hasCategory)
                    
                    HStack {
                        Text("Created categories:")
                        Spacer()
                        
                        Picker("Category", selection: $eventCellViewModel.event.category) {
                            ForEach(multipleCategories, id: \.self) {
                                Text($0)
                            }
                        }.pickerStyle(MenuPickerStyle())
                    }.disabled(eventCellViewModel.event.hasCategory ? false : true)
                }
                
                Section(header: Text("Hours ⏰")){
                    //                    HStack {
                    //                        Text("From Hour:")
                    //                        NumberTextField(value: $eventCellViewModel.event.fromHourOld)
                    //                    }
                    //
                    //                    HStack {
                    //                        Text("To Hour:")
                    //                        NumberTextField(value: $eventCellViewModel.event.toHourOld)
                    //                    }
                    
                    DatePicker("Date", selection: $eventCellViewModel.event.date, displayedComponents: .date)
                    DatePicker("Start Hour", selection: $eventCellViewModel.event.fromHour, displayedComponents: .hourAndMinute)
                    DatePicker("End Hour", selection: $eventCellViewModel.event.toHour, displayedComponents: .hourAndMinute)
                }
                
                Section(header: Text("Link 💻")){
                    TextField("Website", text: $eventCellViewModel.event.category)
                        .textContentType(.URL)
                        .keyboardType(.URL)
                }
                
                Section(header: Text("Style 😎")) {
                    ColorChooser(selectedColor: selectedColor, event: eventCellViewModel)
                    
                    //                    ColorPicker("Background Color", selection: $eventCellViewModel.event.backgroundColor)
                    //                    ColorPicker("Text Color", selection: $eventCellViewModel.event.textColor)
                    
                    
                    
                }
                
                
                
                Button(action: {
                    self.onCommit(self.eventCellViewModel.event)
                    presentationMode.wrappedValue.dismiss()
                    
                }, label: {
                    Text("Save changes").fontWeight(.bold).foregroundColor(.green).padding(4).frame(maxWidth: .infinity)
                })
                .listRowBackground(Color.green.opacity(0.3))
                
                
                
            }.listStyle(GroupedListStyle())
            .navigationBarItems(
                leading:
                    HStack {
                        
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Cancel").foregroundColor(.red).padding(4)
                        }).background(RoundedRectangle(cornerRadius: 10).foregroundColor(.red).opacity(0.1))
                        
                    }
                
                , trailing:
                    HStack{
                        Button(action: {
                            
                            if eventCellViewModel.event.name.isEmpty {
                                showingAlert.toggle()
                            }
                            
                        }, label: {
                            Text("Save").foregroundColor(.green).padding(4)
                        }).background(RoundedRectangle(cornerRadius: 10).foregroundColor(.green).opacity(0.1))
                    }
            )
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Important message 😲"), message: Text("You need to define a name, otherwise cancel and add an event later ☺️"), dismissButton: .default(Text("Sure! ")))
                
            }
            
            .navigationTitle("Edit")
            
        }
    }
}

struct miniEventFormView_Previews: PreviewProvider {
    static var previews: some View {
        miniEventFormView(eventCellViewModel: EventCellViewModel(event: Event(name: "", category: "teste", date: Date(), fromHour: Date(), toHour: Date(), backgroundColor: .blue, textColor: .black)), multipleCategories: ["C1","C2","C3"])
    }
}

class ColorSelected : ObservableObject{
    @Published var selectedColor : Color = fixedColors[0].toSwiftUIColor
    
    func changeColor(_ color: Color) {
        selectedColor = color
    }
}

struct ColorChooser: View {
    
    @ObservedObject var selectedColor : ColorSelected
    @ObservedObject var event : EventCellViewModel
    
    var body: some View {
        HStack(){
            
            ForEach(fixedColors, id: \.self){ uiColor in
                
                Circle().strokeBorder(uiColor.toSwiftUIColor, lineWidth: uiColor.toSwiftUIColor == selectedColor.selectedColor ? 3 : 0).blendMode(.plusDarker)
                    
                    .background(Circle().foregroundColor(uiColor.toSwiftUIColor))
                    .frame( maxWidth: .infinity, minHeight: 22, maxHeight: 22)
                    .onTapGesture {
                        withAnimation{
                            
                            selectedColor.changeColor(uiColor.toSwiftUIColor)
                            event.event.backgroundColor = uiColor.toSwiftUIColor
                        }
                    }
                
            }
            
            
            
        }
    }
}
