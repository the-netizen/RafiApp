//
//  JournalRecordingView.swift
//  Rafi
//
//  Created by Noor Alhassani on 20/06/1447 AH.
//

internal import SwiftUI
import Combine

struct JournalRecordingView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var controller = RecordingController()

    /// Called when recording finishes (returns file URL or nil)
    let onFinished: (URL?) -> Void

    // MARK: - Waveform state
    @State private var barHeights: [CGFloat] = Array(repeating: 0.5, count: 24)
    @State private var isAnimatingWave = true
    private let waveformTimer = Timer
        .publish(every: 0.12, on: .main, in: .common)
        .autoconnect()

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color("bluee"), Color("bluee").opacity(0.4)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                // Back button
                HStack {
                    Button {
                        isAnimatingWave = false
                        let url = controller.stop()
                        onFinished(url)
                        dismiss()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.95))
                                .frame(width: 48, height: 48)

                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .font(.system(size: 20, weight: .medium))
                        }
                    }

                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)

                Spacer()

                // MARK: Waveform box
                ZStack {
                    RoundedRectangle(cornerRadius: 28)
                        .fill(Color.white.opacity(0.85))

                    GeometryReader { geo in
                        HStack(alignment: .center, spacing: 4) {
                            ForEach(barHeights.indices, id: \.self) { index in
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(Color("bluee").opacity(0.9))
                                    .frame(
                                        width: max(3, geo.size.width / CGFloat(barHeights.count * 2)),
                                        height: geo.size.height * barHeights[index]
                                    )
                                    .frame(maxHeight: .infinity, alignment: .center)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal, 16)
                    }
                    .padding(16)
                }
                .frame(height: 160)
                .padding(.horizontal, 40)

                // Timer
                Text(controller.formattedTime)
                    .font(.system(size: 26, weight: .medium))
                    .padding(.top, 24)

                Spacer()

                // MARK: Mic button
                Button {
                    isAnimatingWave = false
                    let url = controller.stop()
                    onFinished(url)
                    dismiss()
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 96, height: 96)
                            .shadow(radius: 8)

                        // 🔹 your asset name here
                        Image("mico")
                            .resizable()
                            .renderingMode(.original)
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            isAnimatingWave = true
            controller.start()
        }
        // Animate bars
        .onReceive(waveformTimer) { _ in
            guard isAnimatingWave else { return }
            withAnimation(.easeInOut(duration: 0.12)) {
                barHeights = barHeights.map { _ in
                    CGFloat.random(in: 0.2...1.0)
                }
            }
        }
    }
}

// MARK: - Recording controller (unchanged)

final class RecordingController: ObservableObject {
    @Published var elapsed: TimeInterval = 0

    private var timer: Timer?
    private let recorder = AudioRecorderService()

    var formattedTime: String {
        let minutes = Int(elapsed) / 60
        let seconds = Int(elapsed) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func start() {
        recorder.startRecording()
        elapsed = 0

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1,
                                     repeats: true) { [weak self] _ in
            self?.elapsed += 1
        }
    }

    func stop() -> URL? {
        timer?.invalidate()
        timer = nil
        return recorder.stopRecording()
    }
}
