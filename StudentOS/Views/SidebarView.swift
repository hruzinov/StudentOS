import SwiftUI

struct SidebarView: View {
    var courses: [Course]
    var semester: Semester
    @State var openCourses = true
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: CoursesView(courses: courses), isActive: $openCourses) {
                    Label("**Courses**", systemImage: "books.vertical.fill")
                }
                NavigationLink(destination: ScheduleView(semester: semester, courses: courses)) {
                    Label("**Schedule**", systemImage: "calendar")
                }
            }
            .listStyle(.sidebar)
        }
    }
}
