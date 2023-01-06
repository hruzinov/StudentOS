import SwiftUI

struct CoursesView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var courses: [Course]
    let columns = [
        GridItem(.adaptive(minimum: 350))
    ]
    @State var showAddCourseScreen = false

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
                        CourseInfoBlockView(course: course)
                    }
                    #if os(macOS)
                    Button(action: {
                        showAddCourseScreen.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showAddCourseScreen) {
                        AddCourseView(courses: $courses)
                    }
                    // TODO: Make add course button for macOS with normal screen
                    #endif
                }.padding()
            }.padding(.top)
            .navigationTitle("Courses")
            #if !os(macOS)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                mode.wrappedValue.dismiss()
            }){
                Image(systemName: "line.3.horizontal")
            }, trailing: Button(action: {
                showAddCourseScreen.toggle()
            }) {
                Image(systemName: "plus")
            }
                .sheet(isPresented: $showAddCourseScreen) {
                    AddCourseView(courses: $courses)
                }
            )
            .onBackSwipe {
                mode.wrappedValue.dismiss()
            }
            #endif
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView(courses: TestData().courses)
    }
}
