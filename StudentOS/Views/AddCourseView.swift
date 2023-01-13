import SwiftUI

struct AddCourseView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var courseTitle: String = ""
    @State var courseProfessor: String = ""
    @State var addButtonDisabled = true
    @State var editIdIndex: Int?
    @Binding var courses: [Course]
    var editMode: EditModeTypes
    var editId: Int?

    var body: some View {
        List {
            Section(header: Text("Course details")) {
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
                    Button("Save") {
                        courses = saveCourse(editMode: editMode, editIdIndex: editIdIndex, courses: courses, courseTitle: courseTitle, courseProfessor: courseProfessor)
                        mode.wrappedValue.dismiss()
                    }.disabled(addButtonDisabled)
                    Spacer()
                }
            }
        }.onAppear {
            if editMode == .edit, let editId = editId {
                for (index, course) in courses.enumerated() {
                    if editId == course.id {
                        print(courses[index].title)
                        editIdIndex = index
                        courseTitle = courses[index].title
                        courseProfessor = courses[index].professor
                    }
                }
            }
        }
    }
}

private func saveCourse(editMode: EditModeTypes, editIdIndex: Int?, courses: [Course], courseTitle: String, courseProfessor: String) -> [Course] {
    var courses = courses
    var saveCourseId: Int
    switch editMode {
    case .create:
        saveCourseId = 0
        while true {
            saveCourseId += 1
            var courseIdMatch = false
            for course in courses {
                if saveCourseId == course.id { courseIdMatch = true }
            }
            if !courseIdMatch { break }
        }

        let newCourse = Course(id: saveCourseId, title: courseTitle, professor: courseProfessor)
        courses.append(newCourse)

    case .edit:
        if let editIdIndex = editIdIndex {
            courses[editIdIndex].title = courseTitle
            courses[editIdIndex].professor = courseProfessor
        }
    }
    return courses
}
// TODO: test iOS Edit
// TODO: test macOS Edit
// TODO: Edit — pasting old data
// TODO: Edits start work normal only after adding courses item(s)
