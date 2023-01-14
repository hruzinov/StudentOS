import XCTest

@testable import StudentOS

final class StudentOSTests: XCTestCase {
    var referenceData: ReferenceData?
    var referenceNewCourse: Course?
    var referenceEditedCourseArray: [Course]?
    var courses: [Course]?
    var testCourseIndex: Int?
    var testCourseId: Int?
    var testCourseTitle: String?
    var testCourseProfessor: String?
    var editedCourseTitle: String?
    var editedCourseProfessor: String?

    override func setUpWithError() throws {
        try super.setUpWithError()
        referenceData = ReferenceData()
        guard let referenceData else {
            fatalError("Reference data can't be fetched")
        }

        // Data for testNewCourseCreationEditingEndDeletion()'s test
        courses = []
        referenceNewCourse = referenceData.newCourse
        referenceEditedCourseArray = referenceData.editedCoursesArr
        testCourseId = 1
        testCourseTitle = "New Course Title"
        testCourseProfessor = "Evgeniy Gruzinov"
        editedCourseTitle = "Edited Course Title"
        editedCourseProfessor = "Evhen Hruzinov"
    }

    override func tearDownWithError() throws {
        referenceData = nil
        referenceNewCourse = nil
        referenceEditedCourseArray = nil
        courses = nil
        testCourseId = nil
        testCourseTitle = nil
        testCourseProfessor = nil
        editedCourseTitle = nil
        editedCourseProfessor = nil

        try super.tearDownWithError()
    }

    func testNewCourseCreationEditingEndDeletion() throws {
        // Testing of new course creation
        guard let testCourses = courses, let testCourseTitle, let testCourseProfessor else {
            fatalError("Test data for a new course can't be fetched")
        }
        courses = saveCourse(editMode: .create, editIdIndex: nil, courses: testCourses, courseTitle: testCourseTitle, courseProfessor: testCourseProfessor)
        XCTAssertEqual(referenceNewCourse, courses?[0], "Course not created or created wrongly")

        // Getting course index in array for editing
        guard let testCourseId, let indexingCourses = courses else {
            fatalError("Test data for getting course index can't be fetched")
        }
        testCourseIndex = getCourseIndex(courses: indexingCourses, id: testCourseId)
        XCTAssertEqual(testCourseIndex, 0, "Failure in getting course array index")

        // Testing of this course editing
        guard let editedCourseTitle, let editedCourseProfessor, let editingCourses = courses else {
            fatalError("Test data for a course editing can't be fetched")
        }
        courses = saveCourse(editMode: .edit, editIdIndex: testCourseIndex, courses: editingCourses, courseTitle: editedCourseTitle, courseProfessor: editedCourseProfessor)
        XCTAssertEqual(referenceEditedCourseArray, courses, "Course not edited or edited wrongly")

        // Testing of this course deletion
        guard let deletingCoursesArray = courses else {
            fatalError("Test data for a course deletion can't be fetched")
        }
        courses = removeCourse(courseId: 1, coursesArray: deletingCoursesArray)
        XCTAssertEqual([], courses, "Course not deleted or deleted wrongly")

    }
}
