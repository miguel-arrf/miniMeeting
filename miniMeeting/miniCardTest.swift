//
//  miniCardTest.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 01/03/2021.
//

import SwiftUI

struct miniCardTest: View {
    
    var event: Event
    
    var body: some View {
        
        VStack {
            
            HStack{
                Text("\(event.name)").fontWeight(.bold).padding([.top, .leading, .trailing])
                Spacer()
            }
        
            HStack{
                
                Text("\(event.category)")
                    .foregroundColor(UIColor(red: 48/255, green: 71/255, blue: 94/255, alpha: 1).toSwiftUIColor)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .padding([.leading, .trailing], 6).padding([.top, .bottom], 7)
                    .background(
                        RoundedRectangle(cornerRadius:10)
                            .foregroundColor(.blue)
                            .opacity(0.5)
                            .transition(.asymmetric(insertion: .scale, removal: .scale))
                    )
                
                Text("PISID")
                    .foregroundColor(.white)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .padding([.leading, .trailing], 6).padding([.top, .bottom], 7)
                    .background(
                        RoundedRectangle(cornerRadius:10)
                            .foregroundColor(.red)
                            .opacity(0.5)
                            .transition(.asymmetric(insertion: .scale, removal: .scale))
                    )
                
                Spacer()
                
            }.padding([.top], 0).padding([.leading, .trailing, .bottom])
            
        }.background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).foregroundColor(Color.blue).opacity(0.1).transition(.asymmetric(insertion: .scale, removal: .scale))).padding()
        
    }
}

struct miniCardTest_Previews: PreviewProvider {
    static var previews: some View {
        miniCardTest(event: Event(name: "Aula PISID", category: "Aulas", date: Date(), fromHour: Date().addingTimeInterval(86400), toHour: Date().addingTimeInterval(96400), backgroundColor: .red, textColor: .orange))
    }
}
