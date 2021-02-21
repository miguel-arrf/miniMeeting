//
//  miniColorPicker.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 20/02/2021.
//

import SwiftUI

struct miniColorPicker: View {
    
    let conic = LinearGradient(gradient: Gradient(colors: [.orange, .purple]), startPoint: .topTrailing, endPoint: .bottomLeading)
    
    var colors = ["Red", "Green", "Blue", "Tartan"]
    @State private var selectedColor = "Red"
    
    @State var openMenu = false
    
    var body: some View {
        
        VStack {
            
            ZStack{
                
                if(openMenu){
                    
                    ZStack(alignment: .topLeading){
                        
                        RoundedRectangle(cornerRadius: 20).foregroundColor(.white).frame(width: 270, height: 100).shadow(color: Color.black.opacity(0.1), radius: 10, x: 0.0, y: 10)
                        
                        HStack{
                            Circle().frame(width: 20, height: 20).foregroundColor(.black).padding()
                            Spacer()
                            Circle().frame(width: 20, height: 20).foregroundColor(.black).padding()
                            Spacer()
                            Circle().frame(width: 20, height: 20).foregroundColor(.black).padding()
                            Spacer()
                            Circle().frame(width: 20, height: 20).foregroundColor(.black).padding()
                        }.frame(maxWidth: 270).padding(.top, 40)
                        
                        Text("Cores")
                            .fontWeight(.bold).padding()
                        
                    }.transition(.asymmetric(insertion: .slide, removal: .opacity))
                }
                
                Button(action: {
                    withAnimation{
                        openMenu.toggle()
                    }
                }, label: {
                    Circle()
                        .fill(conic)
                        .frame(width: 30, height: 30)
                    
                })
            }
            
            
            
            Picker(selection: $selectedColor, label :
                    ZStack{
                        Circle().foregroundColor(.red).frame(width:32, height: 32)
                        Image(systemName: "eyedropper")
                            .font(Font.system(.footnote).weight(.heavy)).foregroundColor(.white)
                        
                    }
            ) {
                ForEach(colors, id: \.self) {texto in
                    HStack{
                        Circle().foregroundColor(.red).frame(width: 20, height: 20)
                        Text(texto)
                    }
                }
                
            }.pickerStyle(MenuPickerStyle())
            
            Text(selectedColor)
            
        }
    }
}

struct miniColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        miniColorPicker()
    }
}
