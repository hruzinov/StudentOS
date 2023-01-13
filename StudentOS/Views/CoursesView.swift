import SwiftUI

struct CoursesView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var courses: [Course]
    let columns = [
        GridItem(.adaptive(minimum: 350))
    ]
    @State var showAddCourseScreen = false
    @State var showEditCourseScreen = false
    @State var editId: Int?
    
    #if os(macOS)
    var lightBG = CGColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
    #else
    var lightBG = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
    #endif
    var backgroundColor: CGColor {
        if colorScheme == .dark { return CGColor(red: 0, green: 0, blue: 0, alpha: 1) }
        else { return lightBG }
    }
    
    var body: some View {
        ZStack {
            Color(backgroundColor)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(courses, id: \.id) { course in
                        CourseInfoBlockView(editFunction: editCourse, deleteFunction: deleteCourse, course: course)
                            .transition(.scale)
                    }
                    #if os(macOS)
                    Button(action: {
                        showAddCourseScreen.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                    // TODO: Make add course button for macOS with normal size
                    #endif
                }.padding()
            }.padding(.top)
            .navigationTitle("Courses")
            #if !os(macOS)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                mode.wrappedValue.dismiss()
            }){
                Image(systemName: "line.horizontal.3")
            }, trailing: Button(action: {
                showAddCourseScreen.toggle()
            }) {
                Image(systemName: "plus")
            })
            .onBackSwipe {
                mode.wrappedValue.dismiss()
            }
            #endif
        }
        .sheet(isPresented: $showAddCourseScreen) {
            AddCourseView(courses: $courses, editId: .constant(0), editMode: .create)
        }.sheet(isPresented: $showEditCourseScreen) {
            AddCourseView(courses: $courses, editId: $editId, editMode: .edit)
        }
    }
    
    func editCourse(courseId: Int) {
        self.editId = courseId
        self.showEditCourseScreen.toggle()
    }
    
    func deleteCourse(courseId: Int) {
        withAnimation {
            self.courses = self.courses.filter{$0.id != courseId}
        }
    }
}
