import SwiftUI

struct ScheduleView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    var backgroundColor: CGColor {
        if colorScheme == .dark { return CGColor(red: 0, green: 0, blue: 0, alpha: 1) }
        else { return CGColor(red: 1, green: 1, blue: 1, alpha: 1) }
    }
    let semester: Semester
    let courses: [Course]
    @State var sortedCourses: Dictionary<Int, Course>? = nil
    @State var sortedSchedule: Dictionary<Int, Array<ScheduleItem>>? = nil
    
    var body: some View {
        ZStack {
            Color(backgroundColor)
            ScrollView {
                ForEach(0..<7, id: \.self) { day in
                    let formattedWeek = formatWeek(offset: day)
                    VStack {
                        HStack {
                            Text(formattedWeek).font(.title2).bold()
                            VStack {
                                Divider()
                            }
                            Spacer()
                        }
                        VStack {
                            if let sortedSchedule = sortedSchedule, let sortedCourses = sortedCourses, let sortedScheduleDay = sortedSchedule[day] {
                                ForEach(sortedScheduleDay, id: \.self) { item in
                                    if let course = sortedCourses[item.course_id] {
                                        HStack {
                                            Text("\(item.time)").bold()
                                            Text("\(course.title)")
                                            Spacer()
                                        }
                                    }
                                }
                            }
                        }
                    }
                            .padding(.bottom, 40)
                }.padding(25)
            }
                    .navigationTitle("Schedule")
                    #if !os(macOS)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: Button(action: {
                        mode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "line.3.horizontal")
                    })
                    #endif

                    .onAppear {
                        sortedSchedule = sortSchedule(scheduleItems: semester.scheduleItems)
                        sortedCourses = sortCourses(courses: courses)
                    }
        }
    }
}

private func formatWeek(offset: Int) -> String {
    var calendar = Calendar.current
    calendar.firstWeekday = 2
    var dateComponent = DateComponents()
    dateComponent.day = offset

    let firstDay = calendar.date(from: calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: Date()))
    guard let firstDay = firstDay else {return "error"}
    let nowDay = calendar.date(byAdding: dateComponent, to: firstDay)
    guard let nowDay = nowDay else {return "error"}
    
    let formattedWeek = DateFormatter()
    formattedWeek.dateFormat = "EEEE"
    
    return formattedWeek.string(from: nowDay)
}

private func sortSchedule(scheduleItems: [ScheduleItem]) -> Dictionary<Int, Array<ScheduleItem>> {
    var calendar = Calendar.current
    calendar.firstWeekday = 2

    let firstDay = calendar.date(from: calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: Date()))!
    
    var tempSchedule: Dictionary<Int, Array<ScheduleItem>> = [
        0: [], 1: [], 2: [], 3: [], 4: [], 5: [], 6: []
    ]
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
        tempSchedule[offset]! += [appendingItem]
    }

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    for item in tempSchedule {
        let key = item.key
        let value = item.value
        let newValue = value
                .map {  ($0, dateFormatter.date(from: $0.time)!) }
                .sorted { $0.1 < $1.1 }
                .map(\.0)
        returnSchedule[key]! += newValue
    }

    return returnSchedule
}

private func sortCourses(courses: [Course]) -> Dictionary<Int, Course>? {
    var returnCourses: Dictionary<Int, Course> = [:]
    for course in courses {
        returnCourses[course.id] = course
    }
    return returnCourses
}
