
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        VStack {
            HeaderView(description: $viewModel.description) {
                viewModel.add()
            }

            ChecklistView(viewModel: viewModel)
        }
    }
}

struct HeaderView: View {
    @Binding var description: String
    var addTask: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image("profile")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 65, height: 65)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(.gray, lineWidth: 1)
                    )

                Text("My Checklist")
                    .font(.title2)
                    .bold()
            }

            HStack {
                TextField("Enter description", text: $description)
                    .textFieldStyle(.roundedBorder)

                Button("Add") {
                    addTask()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}

struct ChecklistView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        List {
            Section("In progress") {
                ForEach(viewModel.inProgress, id: \.self) { task in
                    Button(task) {
                        viewModel.swapToComplete(task: task)
                    }
                }
            }

            Section("Complete") {
                ForEach(viewModel.complete, id: \.self) { task in
                    Button(task) {
                        viewModel.swapToInProgress(task: task)
                    }
                }
            }
        }
    }
}

