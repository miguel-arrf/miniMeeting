//
//  miniSectionHeader.swift
//  miniMeeting
//
//  Created by Miguel Ferreira on 19/02/2021.
//

import SwiftUI
import UserNotifications

struct miniSectionHeader: View {
    
    var event:(String, Color, Color)
    var count :Int = 1
    
    @State var openedSection : Bool = true
    
    var category : (String, Color, Color)
    @ObservedObject var eventListViewModel: EventListViewModel
    @Binding var activeSheet: ActiveSheet?
    @ObservedObject var selectedCell : ObjectToSend
    
    var body: some View {
        VStack{
            HStack {
                
                Group{
                    Text(event.0)
                        .fontWeight(.bold).foregroundColor(event.1)
                    
                    ZStack {
                        Text(String(count)).font(.footnote).fontWeight(.bold).foregroundColor(event.2)
                        RoundedRectangle(cornerRadius: 5).frame(width:25, height:25).foregroundColor(
                            event.1.opacity(0.3)
                        )
                    }
                }.opacity(openedSection ? 1 : 0.5)
                .animation(.easeInOut)
                
                
                Spacer()
                Image(systemName: "chevron.up")
                    .font(Font.system(.body).weight(.semibold)).foregroundColor(event.2)
                    .onTapGesture {
                        withAnimation{
                            openedSection.toggle()
                        }
                    }
                    .rotationEffect(Angle.degrees(openedSection ? 0 : 180))
                    .animation(.easeInOut)
                    .opacity(openedSection ? 1 : 0.5)
            }.padding([.leading, .trailing])
            
            
            if(openedSection){
                ForEach(eventListViewModel.eventCellViewModels.filter {$0.event.category == category.0 }){eventCellViewModel in
                    
                    miniCard(eventCellViewModel: eventCellViewModel)
                        .contextMenu(ContextMenu(menuItems: {
                            
                            Button(action: {
                                yupiNotification(for: eventCellViewModel.event)
                            }, label: {
                                Label("Turn On notification", systemImage: "bell")
                            })
                            
                            Button(action: {
                                selectedCell.changeCell(eventCellViewModel)
                                activeSheet = .second
                            }, label: {
                                Label("Edit", systemImage: "slider.horizontal.3")
                            })
                            
                            Button(action: {
                                
                                EventRepository.shared.db.collection("events").document(eventCellViewModel.event.id!).delete() { err in
                                    
                                    if let err = err {
                                        print("Error removing document: \(err)")
                                    } else {
                                        print("Document successfully removed!")
                                    }
                                    
                                }
                                
                            }, label: {
                                Label("Delete", systemImage: "trash")
                            })
                        }))
                        //                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                        .transition(.asymmetric(insertion: .scale, removal: .scale))
                }
            }
            
            
            
        }
    }
}

func yupiNotification(for event: Event) {
    addNotification(for: event)
}

func getNotification(for event: Event, for center: UNUserNotificationCenter, for number: NSNumber){
    
        let content = UNMutableNotificationContent()
        content.title = "\(event.name)"
        content.subtitle = "\(event.category)"
        content.badge = number
        
        content.sound = UNNotificationSound.default
        
        
        let calendar = Calendar.current
        
        var dateComponents = DateComponents()
        dateComponents.minute = calendar.component(.minute, from: event.fromHour)
        dateComponents.hour = calendar.component(.hour, from: event.fromHour)
        dateComponents.day = calendar.component(.day, from: event.date)
        dateComponents.month = calendar.component(.month, from: event.date)
        dateComponents.year = calendar.component(.year, from: event.date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
    
    
}

func addNotification(for event: Event, number: NSNumber? = 0){
    let center = UNUserNotificationCenter.current()
    
    
    
    center.getNotificationSettings{ settings in
        if settings.authorizationStatus == .authorized{

            let badgeCount = UserDefaults.standard.value(forKey: "NotificationBadgeCount") as! Int + 1
            UserDefaults.standard.setValue(badgeCount, forKey: "NotificationBadgeCount")
            getNotification(for: event, for: center, for: badgeCount as NSNumber)

            
        } else {
            center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success{
                    let badgeCount = UserDefaults.standard.value(forKey: "NotificationBadgeCount") as! Int + 1
                    UserDefaults.standard.setValue(badgeCount, forKey: "NotificationBadgeCount")
                    getNotification(for: event, for: center, for: badgeCount as NSNumber)
//                    UIApplication.shared.applicationIconBadgeNumber = 2
                }else {
                    print("D'oh")
                }
                
            }
        }
    }
    
    
}

#if DEBUG
struct miniSectionHeader_Previews : PreviewProvider {
    
    @State static var activeSheet : ActiveSheet? = ActiveSheet.first
    
    static var previews: some View {
        miniSectionHeader(event: (testDataEvents[0].name,testDataEvents[0].backgroundColor, testDataEvents[0].textColor ), category: ("Teste",.black, .white),eventListViewModel: EventListViewModel(), activeSheet: $activeSheet, selectedCell: ObjectToSend())
    }
    
}
#endif
