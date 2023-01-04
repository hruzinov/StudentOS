import Foundation

struct Schedule {
    enum weekDays: String {
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        case sunday
        
        var name: String {
            rawValue.capitalized
        }
        var shortName: String {
            name.prefix(3) + "."
        }
        var theme: Theme {
            switch self {
            case .monday:
                return .buttercup
            case .tuesday:
                return .sky
            case .wednesday:
                return .orange
            case .thursday:
                return .bubblegum
            case .friday:
                return .lavender
            case .saturday:
                return .poppy
            case .sunday:
                return .seafoam
            }
        }
    }
}

struct ScheduleItem: Identifiable, Hashable {
    var id: UUID = UUID()
    var course_id: Int
    var day: Schedule.weekDays
    var time: String
    var timeDate: Date? = nil
}

struct Semester {
    var id: UUID = UUID()
    var startDate: Date
    var endDate: Date
    var name: String
    var scheduleItems: [ScheduleItem]
    
}
