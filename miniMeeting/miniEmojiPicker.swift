//
//  miniEmojiPicker.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 05/03/2021.
//

import SwiftUI

struct miniEmojiPicker: View {
    var body: some View {
        
        VStack {
            
            HStack{
                Text("Icon:")
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    
                        RoundedRectangle(cornerRadius: 20).frame(width: 35, height: 35).foregroundColor(.blue).opacity(0.2)
                            .overlay(
                                Text("🤩")
                            )
                })
            }
            
//            ScrollView(.horizontal){
//                HStack{
//                    ForEach(fixedEmojis, id: \.self){ emoji in
//                        Text("\(emoji)")
//                    }
//                }
//            }
        }
        
    }
}

struct miniEmojiPicker_Previews: PreviewProvider {
    static var previews: some View {
        Form{
            Section(header: Text("Icon")){
                miniEmojiPicker()
            }
        }
    }
}
