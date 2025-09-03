import SwiftUI

struct TestLogic: View {
    @State private var userInput: String = ""
    let reference : String = "Iam testing my typing speed"
    @State private var startTime: Date?
    @State private var endTime: Date?
    @State private var hasStarted = false
    @State private var isFinished = false
    
    // Work item for detecting "stop typing"
    @State private var typingWorkItem: DispatchWorkItem?

    var body: some View {
        VStack(spacing: 20) {
            Text("Type the following sentence:")
            Text(reference)

            TextField("Make it quick", text: $userInput)
                .padding()
                .onChange(of: userInput) { newValue in
                    // Start timer on first input
                    if !hasStarted && !newValue.isEmpty {
                        startTime = Date()
                        hasStarted = true
                    }

                    // Cancel previous "stop typing" task
                    typingWorkItem?.cancel()
                    
                    // Create a new one to check after 2s of inactivity
                    let workItem = DispatchWorkItem {
                        endTime = Date()
                        isFinished = true
                    }
                    typingWorkItem = workItem
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: workItem)
                }

            let duration = startTime != nil ? Date().timeIntervalSince(startTime!) : nil
            let result = compare(userInput: userInput, reference: reference, duration: duration)

            VStack(spacing: 8) {
                Text("✔️ Correct: \(result.correct)")
                Text("❌ Wrong: \(result.wrong)")
                Text("🎯 Accuracy: \(String(format: "%.1f", result.accuracy))%")
                if duration != nil {
                    Text("⌨️ WPM: \(String(format: "%.1f", result.wpm))")
                        .foregroundColor(.blue)
                }
            }

        }
        .padding()
    }
}

func compare(userInput: String, reference: String, duration : TimeInterval?) -> (correct: Int, wrong : Int, accuracy: Double, wpm: Double) {
    var correct = 0
    var wrong = 0
    
    for (uChar, rChar) in zip(userInput, reference) {
        if uChar == rChar {
            correct += 1
        } else {
            wrong += 1
        }
    }
    
    if userInput.count > reference.count {
        wrong += userInput.count - reference.count
    }
    
    let total = max(userInput.count, 1)
    let accuracy = Double(correct) / Double(total) * 100.0
    var wpm = 0.0
       if let duration = duration, duration > 0 {
           let minutes = duration / 60.0
           wpm = (Double(total) / 5.0) / minutes
       }
    return (correct, wrong, accuracy, wpm)
}

#Preview {
    TestLogic()
}
