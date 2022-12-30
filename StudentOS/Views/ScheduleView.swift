//
//  Created by Evhen Gruzinov on 25.11.2022.
//

import SwiftUI

struct ScheduleView: View {
    var semester: Semester
    var courses: [Course]
    @State var sortedSchedule: Dictionary<Int, Array<ScheduleItem>>? = nil
    
    var body: some View {
        ScrollView {
            ForEach(0..<7, id: \.self) { day in
                let generatedDate = nowWeekDay(offset: day)
//                let rawDate = generatedDate[0] as! Date
                let formattedDate = generatedDate[1] as! String
                let formattedWeek = generatedDate[2] as! String
                VStack {
                    HStack {
                        Text(formattedDate).font(.title).bold()
                        VStack {
                            Divider()
                            HStack {
                                Text(formattedWeek).bold()
                                Spacer()
                            }
                        }
                        Spacer()
                    }.padding(.top, 50)
                    VStack {
                        
                        if let sortedSchedule = sortedSchedule, let sortedScheduleDay = sortedSchedule[day] {
                            ForEach(sortedScheduleDay, id: \.self) { item in
                                HStack {
                                    Text("\(item.course_id)")
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Schedule")
        .padding(50)
        .onAppear {
            sortedSchedule = sortSchedule(scheduleItems: semester.scheduleItems)
        }
    }
}

func nowWeekDay(offset: Int) -> Array<Any> {
    var calendar = Calendar.current
    calendar.firstWeekday = 2
    var dateComponent = DateComponents()
    dateComponent.day = offset

    let firstDay = calendar.date(from: calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: Date()))
    guard let firstDay = firstDay else {return ["error"]}
    
    let nowDay = calendar.date(byAdding: dateComponent, to: firstDay)
    guard let nowDay = nowDay else {return ["error"]}
    
    let formatterDate = DateFormatter()
    formatterDate.dateFormat = "d MMM"
    
    let formattedWeek = DateFormatter()
    formattedWeek.dateFormat = "EEEE"
    
    return [
        nowDay,
        formatterDate.string(from: nowDay),
        formattedWeek.string(from: nowDay)
    ]
}

func sortSchedule(scheduleItems: [ScheduleItem]) -> Dictionary<Int, Array<ScheduleItem>> {
    var calendar = Calendar.current
    calendar.firstWeekday = 2

    let firstDay = calendar.date(from: calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: Date()))!
    
    var returnSchedule: Dictionary<Int, Array<ScheduleItem>> = [
        0: [], 1: [], 2: [], 3: [], 4: [], 5: [], 6: []
    ]
    
    for item in scheduleItems {
        var appendingItem = item
        var offset: Int
        
        switch item.day {
        case .monday:offset = 0
        case .tuesday:offset = 1
        case .wednesday:offset = 2
        case .thursday:offset = 3
        case .friday:offset = 4
        case .saturday:offset = 5
        case .sunday:offset = 6
        }

        let offsetHour = Int(item.time.prefix(2))
        let offsetMinute = Int(item.time.suffix(2))

        var dateComponent = DateComponents()
        dateComponent.day = offset
        dateComponent.hour = offsetHour
        dateComponent.minute = offsetMinute
        let nowDayTime = calendar.date(byAdding: dateComponent, to: firstDay)

        appendingItem.timeDate = nowDayTime
        returnSchedule[offset]! += [appendingItem]
    }
    
    return returnSchedule
}
