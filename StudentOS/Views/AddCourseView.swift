import SwiftUI

struct AddCourseView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var courseTitle: String = ""
    @State var courseProfessor: String = ""
    
    var body: some View {
            Form {
                Section {
                    HStack {
                        Text("Course title: ")
                        TextField("Math", text: $courseTitle)
                    }
                    HStack {
                        Text("Course professor: ")
                        TextField("John Smith", text: $courseProfessor)
                    }
                }
                Section {
                    HStack {
                        Spacer()
                        Button("Add") {
                            mode.wrappedValue.dismiss()
                        }
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Button("Cancel") {
                            mode.wrappedValue.dismiss()
                        }.foregroundColor(.red)
                        Spacer()
                    }
                }
            }
        }
        
}

struct AddCourseView_Previews: PreviewProvider {
    static var previews: some View {
        AddCourseView()
    }
}
