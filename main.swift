// MARK: - Nameable

// I've added this just to demonstrate Protocol Inheritance. Domain and Task protocols will both inherit this Nameable protocol so any type conforming to Domain or Task will also have to conform to Nameable. Later we can create a collection of `Nameable` things where we don't care what their actual type is, only that they have a name.
protocol Nameable {
    var name: String { get }
}

// MARK: - Domain

protocol Domain: Nameable {
    // I've removed all the `set`s because they weren't being used in the code.
    var tasks: [Task] { get }
    
    // Changed from `Float` to `TimeInterval` which is actually a typealias for Double which refers to "a number of seconds" according to type definition.
    var averageTimeSpent: TimeInterval { get }
}

// Common default implementations can go here. Conforming types can replace these by implementing their own version.
extension Domain {
    var timeSpent: TimeInterval {
        return tasks
            .map({ $0.duration })
            .reduce(0, +)
    }
    
    var averageTimeSpent: TimeInterval {
        return timeSpent / Double(tasks.count)
    }
}

// MARK: - Task

protocol Task: Nameable {
    var duration: TimeInterval { get }
}

// MARK: - Conforming Domains

struct Education: Domain {
    var name: String
    var tasks: [Task]
    
    init(name: String = "Education", tasks: [Task] = []) {
        self.name = name
        self.tasks = tasks
    }
}

struct Exercise: Domain {
    var name: String
    var tasks: [Task]
    var totalCaloriesBurned: Int
    
    init(name: String = "Exercise", tasks: [Task] = [], totalCals: Int = 0) {
        self.name = name
        self.tasks = tasks
        self.totalCaloriesBurned = totalCals
    }
}

// MARK: - Conforming Tasks

struct Study: Task {
    var name: String
    var duration: TimeInterval
    
    init(name: String = "Study", duration: TimeInterval) {
        self.name = name
        self.duration = duration
    }
}

struct Homework: Task {
    var name: String
    var duration: TimeInterval
    
    init(name: String = "Homework", duration: TimeInterval) {
        self.name = name
        self.duration = duration
    }
}

struct GeneralTask: Task {
    var name: String
    var duration: TimeInterval
    
    init(name: String, duration: TimeInterval) {
        self.name = name
        self.duration = duration
    }
}

// At this point all these types are identical except for their name which really indicates a mutually exclusive category of Task. Feels to me like a job for an enum:

enum TaskType {
    case study, homework, general
}

struct EnumBasedTask: Task {
    var name: String
    var duration: TimeInterval
    var type: TaskType
}

let coding = EnumBasedTask(
    name: "Write Code",
    duration: .greatestFiniteMagnitude,
    type: .study
)

// MARK: - Instances and Experimentation.

var study = Study(duration: 30)
var hw = Homework(duration: 60)

var masters = Education(tasks: [study, hw])
masters.tasks
masters.timeSpent

var party = GeneralTask(name: "Party", duration: 10000)
var underGrad = Education(name: "Under Grad", tasks: [study, hw, party])
underGrad.name
underGrad.timeSpent

var legWorkout = GeneralTask(name: "Leg Workout", duration: 60)
var armWorkout = GeneralTask(name: "Leg Workout", duration: 30)
var workout = Exercise(tasks: [legWorkout, armWorkout], totalCals: 250)
workout.name
workout.averageTimeSpent
workout.totalCaloriesBurned


// Example of list of Nameable things. We don't care if they are Education, Exercise, Study, Homework, GeneralTask, or EnumBasedTasks. Our only concern is they all have a name.
let nameableThings: [Nameable] = [study, hw, masters, party, underGrad, legWorkout, armWorkout, workout, coding]

let namesAsOneLargeString = nameableThings
    .map({ $0.name })
    .joined(separator: ", ")

print(namesAsOneLargeString)

