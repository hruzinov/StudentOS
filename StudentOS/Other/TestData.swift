import Foundation

class TestData {
    
    let courses: [Course] = [
        Course(id: 1, title: "Rocket Science", professor: "Sergei Korolev"),
        Course(id: 2, title: "Ukrainian", professor: "Taras Shevchenko")
    ]
    
    func getSemester() -> Semester {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        var dateComponent = DateComponents()
        dateComponent.day = 6

        let firstDateInWeek = calendar.date(from: calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: Date()))!
        let lastDateInWeek = calendar.date(byAdding: dateComponent, to: firstDateInWeek)!

        let semester = Semester(startDate: firstDateInWeek, endDate: lastDateInWeek, name: "Test semester", scheduleItems: [
            ScheduleItem(course_id: 1, day: .monday, time: "11:00"),
            ScheduleItem(course_id: 1, day: .thursday, time: "12:30"),
            ScheduleItem(course_id: 1, day: .tuesday, time: "13:30"),
            ScheduleItem(course_id: 1, day: .saturday, time: "14:00"),
            ScheduleItem(course_id: 2, day: .wednesday, time: "15:30"),
            ScheduleItem(course_id: 2, day: .friday, time: "16:00"),
            ScheduleItem(course_id: 2, day: .tuesday, time: "17:00"),
            ScheduleItem(course_id: 2, day: .saturday, time: "10:30"),
        ])
        return semester
    }
}
