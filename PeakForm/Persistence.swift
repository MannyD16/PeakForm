import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PeakForm")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // Function to save a workout session
    func saveWorkout(date: Date, duration: Int, calories: Int, exercise: String) {
        let context = container.viewContext
        let newWorkout = WorkoutSession(context: context)
        newWorkout.id = UUID()
        newWorkout.date = date
        newWorkout.duration = Int64(duration)
        newWorkout.caloriesBurned = Int64(calories)
        newWorkout.exerciseType = exercise

        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    // Function to fetch workout sessions
    func fetchWorkouts() -> [WorkoutSession] {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<WorkoutSession> = WorkoutSession.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching workouts: \(error)")
            return []
        }
    }
}

