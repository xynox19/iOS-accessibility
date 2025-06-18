// AccessiOS: A Simple Accessibility Trainer App in SwiftUI

import SwiftUI
import AVFoundation

@main
struct AccessiOSApp: App {
    var body: some Scene {
        WindowGroup {
            OnboardingView()
        }
    }
}

// MARK: - OnboardingView
struct OnboardingView: View {
    @State private var step = 0

    let steps = [
        "Welcome to AccessiOS!",
        "This app will help you learn how to use Apple accessibility tools.",
        "Let's begin with simple gestures like Tap and Swipe."
    ]

    var body: some View {
        VStack(spacing: 30) {
            Text(steps[step])
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()

            Button(action: {
                speak(text: steps[step])
            }) {
                Label("Hear it", systemImage: "speaker.wave.2.fill")
            }
            .accessibilityLabel("Read this step aloud")

            Button("Continue") {
                if step < steps.count - 1 {
                    step += 1
                } else {
                    // Navigate to trainer view
                    UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: GestureTrainerView())
                }
            }
            .padding()
        }
    }

    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        AVSpeechSynthesizer().speak(utterance)
    }
}

// MARK: - GestureTrainerView
struct GestureTrainerView: View {
    @State private var feedback = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Practice Area")
                .font(.title)

            Text("Try tapping anywhere on the screen")
                .font(.headline)
                .padding()

            Spacer()

            Rectangle()
                .fill(Color.blue.opacity(0.2))
                .frame(height: 300)
                .cornerRadius(12)
                .onTapGesture {
                    feedback = "Nice tap! Well done."
                    speak(text: feedback)
                }

            Spacer()

            Text(feedback)
                .font(.body)
                .padding()
                .foregroundColor(.green)
        }
        .padding()
    }

    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        AVSpeechSynthesizer().speak(utterance)
    }
}
