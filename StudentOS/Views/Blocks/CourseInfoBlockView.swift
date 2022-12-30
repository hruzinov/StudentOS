//
//  Created by Evhen Gruzinov on 24.11.2022.
//

import SwiftUI

struct CourseInfoBlockView: View {
    @Environment(\.colorScheme) var colorScheme
    var backgroundColor: Color {
        if colorScheme == .light { return Color.white } else { return Color(red: 36/255, green: 36/255, blue: 36/255) }
    }
    var borderColor: Color {
        if colorScheme == .light { return Color(red: 178/255, green: 178/255, blue: 178/255) }
        else { return Color.black }
    }
    var course: Course
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(course.title)
                    .font(.title3).bold()
                Text(course.professor)
//                HStack {
//                    ForEach(course.schedule) { schedule in
//                        Text("\(schedule.day.shortName) *\(schedule.time)*")
//                            .padding([.leading,.trailing], 3)
//                            .padding([.top,.bottom], 2)
//                            .background(schedule.day.theme.mainColor)
//                            .foregroundColor(schedule.day.theme.accentColor)
//                            .cornerRadius(5)
//                    }
//                }
                Text("**Tasks:** 1234").padding(.top, 1)
            }
            Spacer()
            Image(systemName: "arrow.right.circle").font(.title2)
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

struct CourseInfoBlockView_Previews: PreviewProvider {
    static var previews: some View {
        CourseInfoBlockView(course: TestData().courses[0])
            .previewLayout(.fixed(width: 400, height: 400))
    }
}
