import SwiftUI

struct CourseInfoBlockView: View {
    @Environment(\.colorScheme) var colorScheme
    var editFunction: (Int) -> Void
    var deleteFunction: (Int) -> Void
    var backgroundColor: Color {
        if colorScheme == .light { return Color.white } else { return Color(red: 36/255, green: 36/255, blue: 36/255) }
    }
    var borderColor: Color {
        if colorScheme == .light { return Color(red: 178/255, green: 178/255, blue: 178/255) }
        else { return Color.black }
    }
    var course: Course
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(course.title)
                    .font(.title3).bold()
                Text(course.professor)
                Text("**Tasks:** 1234").padding(.top, 1)
            }
            Spacer()
            Menu {
                Button {
                    self.editFunction(course.id)
                } label: {
                    Label("Edit", systemImage: "trash")
                }

                Menu {
                    if #available(iOS 15.0, macOS 12.0, *) {
                        Button("Confirm", role: .destructive) {
                            self.deleteFunction(course.id)
                        }
                    } else {
                        Button("Confirm") {
                            self.deleteFunction(course.id)
                        }
                    }
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            } label: {
                Image(systemName: "ellipsis.circle").font(.title2)
            }
        }
        .padding()
        .background(backgroundColor)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(borderColor, lineWidth: 1)
        )
    }
}

//struct CourseInfoBlockView_Previews: PreviewProvider {
//    static var previews: some View {
//        CourseInfoBlockView(deleteFunction: {_ in }, course: TestData().courses[0])
//            .previewLayout(.fixed(width: 400, height: 400))
//    }
//}
