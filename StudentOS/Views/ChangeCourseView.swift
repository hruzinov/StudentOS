import SwiftUI

struct ChangeCourseView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var courseTitle: String = ""
    @State var courseProfessor: String = ""
    @State var addButtonDisabled = true
    @State var editIdIndex: Int?
    @Binding var courses: [Course]
    @Binding var courseEditId: Int?
    var changeMode: ChangeModeTypes

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
                        courses = saveCourse(editMode: changeMode, editIdIndex: editIdIndex, courses: courses, courseTitle: courseTitle, courseProfessor: courseProfessor)
                        mode.wrappedValue.dismiss()
                    }.disabled(addButtonDisabled)
                    Spacer()
                }
            }
        }.onAppear {
            if changeMode == .edit, let editId = courseEditId {
                editIdIndex = getCourseIndex(courses: courses, id: editId)
                if let editIdIndex {
                    courseTitle = courses[editIdIndex].title
                    courseProfessor = courses[editIdIndex].professor
                }
            }
        }
    }
}