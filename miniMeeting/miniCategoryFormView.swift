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
    
    @ObservedObject var selectedEmoji : EmojiSelected = EmojiSelected()
    @ObservedObject var selectedColor : ColorSelected = ColorSelected()
    
    @State private var showingAlert = false
    
    var body: some View {
        
        NavigationView{
            Form{
                
                VStack {
                    miniCategoryHeader(category: categoryViewModel, withDetailView: false).padding(.vertical)
                }
                
                Section(header: Text("Icon")){
                    EmojiChooser(selectedEmoji: selectedEmoji, category: categoryViewModel)
                }
                
                Section(header: Text("Title 📝").padding(.top)){
                    TextField("Name", text: $categoryViewModel.category.name)
                }
                
                Section(header: Text("Style 😎")) {
                    ColorChooserCategory(selectedColor: selectedColor, category: categoryViewModel)
                    
                }
                
                
                Button(action: {
                    self.onCommit(self.categoryViewModel.category)
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
                            
                            if categoryViewModel.category.name.isEmpty {
                                showingAlert.toggle()
                            }else{
                                self.onCommit(self.categoryViewModel.category)
                                presentationMode.wrappedValue.dismiss()
                            }
                            
                        }, label: {
                            Text("Save").foregroundColor(.green).padding(4)
                        }).background(RoundedRectangle(cornerRadius: 10).foregroundColor(.green).opacity(0.1))
                    }
            )
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Important message 😲"), message: Text("You need to define a name, otherwise cancel and add an event later ☺️"), dismissButton: .default(Text("Sure! ")))
                
            }
            .navigationTitle("New Section")
        }
        
    }
}

struct miniCategoryFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            miniCategoryFormView(categoryViewModel: CategoryViewModel(category: Category( name: "Escola", backgroundColor: fixedColors[0], textColor: .black, emoji: fixedEmojis[0])))
            
            //            EmojiChooser(selectedEmoji: EmojiSelected(), category: CategoryViewModel(category: Category(name: "teste", backgroundColor: .orange, textColor: .black, emoji: fixedEmojis[0])))
        }
        
    }
}


class EmojiSelected : ObservableObject{
    @Published var selectedEmoji : String = fixedEmojis[0]
    
    func changeEmoji(_ emoji: String) {
        selectedEmoji = emoji
    }
}

struct EmojiChooser: View {
    
    @ObservedObject var selectedEmoji : EmojiSelected
    @ObservedObject var category : CategoryViewModel
    
    var body: some View {
        
        ZStack {
            

            ScrollView(.horizontal, showsIndicators: false){
                HStack(){
                    
                    ForEach(fixedEmojis, id: \.self){ emoji in
                        
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(emoji == selectedEmoji.selectedEmoji ? category.category.backgroundColor.opacity(1) : .gray.opacity(0.3))
                            .blendMode(.multiply)
                            .frame(width: 30, height: 30)
                            .overlay(
                                Text("\(emoji)").opacity(emoji == selectedEmoji.selectedEmoji ? 1 : 0.3)
                            ).padding([.trailing])
                            .onTapGesture {
                                withAnimation{
                                    selectedEmoji.changeEmoji(emoji)
                                    category.category.emoji = emoji
                                }
                            }
                        
                        
                    }
                }.padding([.leading], 10)
                
                
            }
            
            HStack{
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color("BlackAndWhite"), Color("BlackAndWhite").opacity(0.01)]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: 20, height: 30)
                Spacer()
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color("BlackAndWhite"), Color("BlackAndWhite").opacity(0.01)]), startPoint: .trailing, endPoint: .leading))
                    .frame(width: 20, height: 30)            }
            
        }
    }
}


struct ColorChooserCategory: View {
    
    @ObservedObject var selectedColor : ColorSelected
    @ObservedObject var category : CategoryViewModel
    
    var body: some View {

            
            HStack(){
                
                ForEach(fixedColors, id: \.self){ uiColor in
                    
                    Circle().strokeBorder(uiColor, lineWidth: uiColor == selectedColor.selectedColor ? 3 : 0).blendMode(.plusDarker)
                        
                        .background(Circle().foregroundColor(uiColor))
                        .frame( maxWidth: .infinity, minHeight: 22, maxHeight: 22)
                        .onTapGesture {
                            withAnimation{
                                
                                selectedColor.changeColor(uiColor)
                                category.category.backgroundColor = uiColor
                            }
                        }
                    
                }
                
                
                
            
        }
    }
}
