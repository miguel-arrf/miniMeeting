//
//  miniCard.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 18/02/2021.
//

import SwiftUI

struct miniCard: View {
    
    @ObservedObject var eventCellViewModel: EventCellViewModel
        
//    @State var showingEdit = false
    
    var body: some View {
                

            HStack{
                Text(eventCellViewModel.event.name)
                    .fontWeight(.bold)
                    .foregroundColor(eventCellViewModel.event.textColor)
                
                Spacer()
                
                HStack{
                    Text("\(eventCellViewModel.event.fromHour)").fontWeight(.bold).foregroundColor(eventCellViewModel.event.backgroundColor)
                    
                    Image(systemName: "arrow.right")
                        .font(Font.system(.footnote).weight(.heavy)).foregroundColor(eventCellViewModel.event.textColor)
                    
                    Text(String(eventCellViewModel.event.toHour)).fontWeight(.bold).foregroundColor(eventCellViewModel.event.backgroundColor)
                }.frame(minWidth:80).padding(3).padding([.leading,.trailing],10).background(
                    Color.white
                        .clipShape(RoundedRectangle(cornerRadius:20))
                )
                
            }.padding().frame(maxWidth:.infinity)
            .background(eventCellViewModel.event.backgroundColor.opacity(0.3).clipShape(RoundedRectangle(cornerRadius:20)))
            
            
            .contentShape(RoundedRectangle(cornerRadius: 19, style: .continuous))
            .padding()
        
    }
    
    
    
}

struct miniCard_Previews: PreviewProvider {
    static var previews: some View {
        miniCard(eventCellViewModel: EventCellViewModel(event: Event(name: "Teste", fromHour: 0, toHour: 0, category: "teste", backgroundColor: .blue, textColor: .black)))
    }
}

