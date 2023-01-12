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
            Section(header: Text("Coruse details")) {
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
                        mode.wrappedValue.dismiss()
                    }.disabled(addButtonDisabled)
                    Spacer()
                }
            }
        }.onAppear {
            if editMode == .edit, let editId = editId {
                print("hello")
                for (index, course) in courses.enumerated() {
                    if editId == course.id {
                        print("hello")
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
