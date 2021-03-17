//
//  miniCard.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 18/02/2021.
//

import SwiftUI

struct miniCard: View {
    
    @ObservedObject var eventCellViewModel: EventCellViewModel
        
    var body: some View {
        
        
        HStack{
            withAnimation{
                Text(eventCellViewModel.event.name)
                    .fontWeight(.bold)
                    .foregroundColor(eventCellViewModel.event.textColor)
            }
            
            
            Spacer()

            
        }.padding().frame(maxWidth:.infinity)
        .background(eventCellViewModel.event.backgroundColor.clipShape(RoundedRectangle(cornerRadius:20)))
        
        .contentShape(RoundedRectangle(cornerRadius: 20, style: .circular))
        
        
    }
    
    
    
}

func formatHour(_ hour: Date) -> String {
    /*
     let formatter = DateFormatter()
     formatter.timeStyle = .short
     let dateString = formatter.string(from: Date())
     */
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    
    return formatter.string(from: hour)
}

struct miniCard_Previews: PreviewProvider {
    static var previews: some View {
        miniCard(eventCellViewModel: EventCellViewModel(event: Event(name: "oioioioi", category: "teste", backgroundColor: .blue, textColor: .black)))
    }
}

