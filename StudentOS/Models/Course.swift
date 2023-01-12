import Foundation

struct Course {
    let id: Int
    var title: String
    var professor: String
}

enum EditModeTypes {case edit, create}
