protocol Domain {
    var tasks : [Task] {get set}
    var name : String {get set}
    var timeSpent : Int {get}
    var averageTimeSpent : Float {get}
}

protocol Task {
    var name : String {get set}
    var duration : Int {get set}
}



struct Education : Domain{
    var name : String
    var tasks: [Task]
    var timeSpent: Int {
        var sum = 0
        for task in tasks{
            sum += task.duration
        }
        return sum
    }
    
    var averageTimeSpent: Float{
        return Float(timeSpent) / Float(tasks.count)
    }
    
    init(name: String = "Education", tasks: [Task] = []) {
        self.name = name
        self.tasks = tasks
    }
}

struct Exercise : Domain {
    var name: String
    var tasks: [Task]
    var totalCaloriesBurned: Int
    var timeSpent: Int {
        var sum = 0
        for task in tasks{
            sum += task.duration
        }
        return sum
    }
    var averageTimeSpent: Float{
        return Float(timeSpent) / Float(tasks.count)
    }
    
    
    init(name: String = "Exercise", tasks: [Task] = [], totalCals: Int = 0) {
        self.name = name
        self.tasks = tasks
        self.totalCaloriesBurned = totalCals
    }
}

struct Study : Task{
    var name: String
    var duration: Int
    
    init(name: String = "Study", duration: Int) {
        self.name = name
        self.duration = duration
    }
}

struct Homework : Task {
    var name: String
    var duration: Int
    
    init(name: String = "Homework", duration: Int) {
        self.name = name
        self.duration = duration
    }
}

struct GeneralTask : Task {
    var name: String
    var duration: Int
    
    init(name: String, duration: Int) {
        self.name = name
        self.duration = duration
    }
}



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


