//
//  Created by Evhen Gruzinov on 23.11.2022.
//

import SwiftUI

@main
struct StudentOSApp: App {
    var semester = TestData().getSemester()
    var courses = TestData().courses
    var body: some Scene {
        WindowGroup {
            SidebarView(courses: courses, semester: semester)
        }
    }
}
