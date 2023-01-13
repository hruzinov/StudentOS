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
                    let formattedWeek = CalendarFunctions().formatWeek(offset: day)
                    
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
                        Image(systemName: "line.horizontal.3")
                    })
                    .onBackSwipe {
                        mode.wrappedValue.dismiss()
                    }
                    #endif

                    .onAppear {
                        sortedSchedule = CalendarFunctions().sortSchedule(scheduleItems: semester.scheduleItems)
                        sortedCourses = sortCourses(courses: courses)
                    }
        }
    }
}

private func sortCourses(courses: [Course]) -> Dictionary<Int, Course> {
    var returnCourses: Dictionary<Int, Course> = [:]
    for course in courses {
        returnCourses[course.id] = course
    }
    return returnCourses
}
