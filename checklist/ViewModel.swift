
import Foundation

class ViewModel: ObservableObject {
    @Published var description: String = ""
    @Published var inProgress: [String] = []
    @Published var complete: [String] = []

    func add() -> Void {
        inProgress.append(description)
        description = ""
    }

    func swapToInProgress(task: String) -> Void {
        if let index = complete.firstIndex(of: task) {
            complete.remove(at: index)
            inProgress.append(task)
        }
    }

    func swapToComplete(task: String) -> Void {
        if let index = inProgress.firstIndex(of: task) {
            inProgress.remove(at: index)
            complete.append(task)
        }
    }
}

