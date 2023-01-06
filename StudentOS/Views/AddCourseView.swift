import SwiftUI

struct AddCourseView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var courseTitle: String = ""
    @State var courseProfessor: String = ""
    @State var addButtonDisabled = true
    @Binding var courses: [Course]
    
    var body: some View {
        List {
            Section(header: Text("New coruse details")) {
                HStack {
                    Text("Course title: ")
                    TextField("Math", text: $courseTitle)
                        .onChange(of: courseTitle) { newValue in
                            if courseTitle == "" || courseProfessor == "" {
                                addButtonDisabled = true
                            } else {
                                addButtonDisabled = false
                            }
                        }
                }
                HStack {
                    Text("Course professor: ")
                    TextField("John Smith", text: $courseProfessor)
                        .onChange(of: courseProfessor) { newValue in
                            if courseTitle == "" || courseProfessor == "" {
                                addButtonDisabled = true
                            } else {
                                addButtonDisabled = false
                            }
                        }
                }
            }
            Section {
                HStack {
                    Spacer()
                    Button("Cancel") {
                        mode.wrappedValue.dismiss()
                    }.foregroundColor(.red)
                    Spacer()
                    Divider()
                    Spacer()
                    Button("Add") {
                        var newCourseId = 0
                        
                        while true {
                            newCourseId += 1
                            var courseIdMatch = false
                            for course in courses {
                                if newCourseId == course.id { courseIdMatch = true }
                            }
                            if !courseIdMatch { break }
                        }
                        let newCourse = Course(id: newCourseId, title: courseTitle, professor: courseProfessor)
                        courses.append(newCourse)
                        mode.wrappedValue.dismiss()
                    }.disabled(addButtonDisabled)
                    Spacer()
                }
            }
        }
    }
}
