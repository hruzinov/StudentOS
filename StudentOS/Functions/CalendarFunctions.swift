import Foundation

struct CalendarFunctions {
    func formatWeek(offset: Int) -> String {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        var dateComponent = DateComponents()
        dateComponent.day = offset

        let firstDay = calendar.date(from: calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: Date()))
        guard let firstDay = firstDay else {return "error"}
        let nowDay = calendar.date(byAdding: dateComponent, to: firstDay)
        guard let nowDay = nowDay else {return "error"}
        
        let formattedWeek = DateFormatter()
        formattedWeek.dateFormat = "EEEE"
        
        return formattedWeek.string(from: nowDay)
    }

    func sortSchedule(scheduleItems: [ScheduleItem]) -> Dictionary<Int, Array<ScheduleItem>> {
        var calendar = Calendar.current
        calendar.firstWeekday = 2

        let firstDay = calendar.date(from: calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: Date()))!
        
        var tempSchedule: Dictionary<Int, Array<ScheduleItem>> = [
            0: [], 1: [], 2: [], 3: [], 4: [], 5: [], 6: []
        ]
        var returnSchedule: Dictionary<Int, Array<ScheduleItem>> = [
            0: [], 1: [], 2: [], 3: [], 4: [], 5: [], 6: []
        ]
        
        for item in scheduleItems {
            var appendingItem = item
            var offset: Int
            
            switch item.day {
            case .monday:offset = 0
            case .tuesday:offset = 1
            case .wednesday:offset = 2
            case .thursday:offset = 3
            case .friday:offset = 4
            case .saturday:offset = 5
            case .sunday:offset = 6
            }

            let offsetHour = Int(item.time.prefix(2))
            let offsetMinute = Int(item.time.suffix(2))

            var dateComponent = DateComponents()
            dateComponent.day = offset
            dateComponent.hour = offsetHour
            dateComponent.minute = offsetMinute
            let nowDayTime = calendar.date(byAdding: dateComponent, to: firstDay)

            appendingItem.timeDate = nowDayTime
            tempSchedule[offset]! += [appendingItem]
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        for item in tempSchedule {
            let key = item.key
            let value = item.value
            let newValue = value
                    .map {  ($0, dateFormatter.date(from: $0.time)!) }
                    .sorted { $0.1 < $1.1 }
                    .map(\.0)
            returnSchedule[key]! += newValue
        }

        return returnSchedule
    }
}
