import Foundation

struct Course: Equatable {
    let id: Int
    var title: String
    var professor: String
}

enum ChangeModeTypes {case edit, create}


func getCourseIndex(courses: [Course], id: Int) -> Int? {
    for (index, course) in courses.enumerated() {
        if id == course.id {
            return index
        }
    }
    return nil
}

func saveCourse(editMode: ChangeModeTypes, editIdIndex: Int?, courses: [Course], courseTitle: String, courseProfessor: String) -> [Course] {
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

func removeCourse(courseId: Int, coursesArray: [Course]) -> [Course] {
    let newCoursesArray = coursesArray.filter{$0.id != courseId}
    return newCoursesArray
}

func sortCourses(courses: [Course]) -> Dictionary<Int, Course> {
    var returnCourses: Dictionary<Int, Course> = [:]
    for course in courses {
        returnCourses[course.id] = course
    }
    return returnCourses
}
